Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D7FCCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHKX-0000vc-F9; Tue, 18 Nov 2025 03:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLHKU-0000nM-VL
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLHKQ-0001J9-BP
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763455483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvBzZyeqDE0awYgcTrOUR4nEuRK4TuBA73+hSBjBlcU=;
 b=Ww3Pgef9UWOrS8OeDIyes8wv3s6PxUkyJppTRvck6G+Q8SpqmpvGP3m65UJ3afAc9k78Dv
 YFlKf/xrrUflslzQeqOqU2REymNn573pH+N5mxr2WIKgLEofT3aeD5w0UPgRZ+hkdQ2Ot/
 6JKEOknLYDW/5UHYL6PSz8LI61KRkLw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-9cfSHnwBP22cptsbq79tfA-1; Tue, 18 Nov 2025 03:44:41 -0500
X-MC-Unique: 9cfSHnwBP22cptsbq79tfA-1
X-Mimecast-MFC-AGG-ID: 9cfSHnwBP22cptsbq79tfA_1763455480
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2ad2a58cso2783538f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 00:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763455480; x=1764060280; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvBzZyeqDE0awYgcTrOUR4nEuRK4TuBA73+hSBjBlcU=;
 b=dpBpDo8/X4qHCWNscJcbHk7zTxkMUEs/J37nek4hS3JqkHw2CQExasGsilS7A2tRER
 KHDn8IBE/TCTQw5+RtoJ25xYUZihw6S9z7VOHUu6k7SwEP+Pj3iCcLzW4LznjrpjLZn3
 7K6e7KviqX99LL56zXPk0eOLFHqiAW3qYgTlk7kMoaUvD6wlh1LtdEG/hztzHTY3Cd4y
 +/UNELZ9SlNBRsUIgA53Wk25bRramLjbRN4apz72w35oUzXnfVJyJHMTn9T69CKMWMtz
 AZoo4IIcuaheLuxjJQ9BvkxWq2p/b/FfHdozDQFUm+3/C7S7ztq2avJ+xfNPDNsmjdPD
 +mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763455480; x=1764060280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MvBzZyeqDE0awYgcTrOUR4nEuRK4TuBA73+hSBjBlcU=;
 b=VwBlP1LGwG7zQ4y2MWoyIXTmNQLgWtsxE601eRbsZ+BfAKO4rqSL5pDB6LR8llOXyY
 vl9mzBCIC6h2SIhHlWB/Hfl/pM1umC09ju+FKsfWmbg1CO4h17Ki8NNCt8s+QMKS1zBh
 weogcjT7ne5VepygHb8fygJtA2xLaDyQXxDvbL+xz2rJrExuSryocB7tfVbk9+H7VAcm
 FnnNgXzDroRDS+RBX/LoXuQTAWRkhJVXP2A4e6l3ya97FhtENJFrFAWLYX906tcx261J
 OSeoz4SxJqvDEKGn5yjmGjDnHcNJCkq0jL/iN5gvcNzOa/6q4lVOG+TMTCFM0XWiD3/l
 OGeA==
X-Gm-Message-State: AOJu0YzL4KwMbWQ22YukdRyztv2l0xoxSSpX+cLN5lTb2gkxOPTZcdM4
 NHgwsfgslmNWKhp1ePe0qiFULDpe3PdNZL4d5za76pSnVl0Hp0IYKBouoJ9xbk77tovbmkjCF4f
 TQFe6Ud5bRnyOIF7VZLkgw0YXXClSThKBOIUOljn1PP7PicjkQt9LQ9OUF6IkCN37BNLLhrP05T
 GCT40OCeA3Dnn9TSxxqsCMrCwbwdNpiQE=
X-Gm-Gg: ASbGncv5H2FDjKDlyOnBcupDqJkDT93PwW15gPzWlOIaP9WqN7deadGuYmF/rzH5Lhs
 QsmLoCTadh/WtVYzcC7BZ9r2pCsa5bDix39iohBG+FhkSE2UokaQnLx/v2+WDx2YAlEWw29buP/
 FyQn1AobaBt6MY5IaRTBcI9rIlY1TfV8C4KIJxJNXVSLkGP3FSJvpZwB4cYi1G62euZJp/LOz5S
 IjZWwlJWg27rkdO3aMpX5cVxGrFP7wD62VisDXVJuboYFNLc84emBBaO5+K1N7eDI/8Bbk=
X-Received: by 2002:a5d:5d03:0:b0:429:d391:642e with SMTP id
 ffacd0b85a97d-42b593742fdmr14123765f8f.30.1763455479765; 
 Tue, 18 Nov 2025 00:44:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYBb00NPR0bwpQ1prqZMlD2GHOrxd4d6LK2fUEYGRJHPeSHEmV6Fh9YUM2WG7hzJ3/VvempdJLJBRnq/VNfeg=
X-Received: by 2002:a5d:5d03:0:b0:429:d391:642e with SMTP id
 ffacd0b85a97d-42b593742fdmr14123749f8f.30.1763455479411; Tue, 18 Nov 2025
 00:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20251118065817.835017-1-zhao1.liu@intel.com>
 <20251118065817.835017-5-zhao1.liu@intel.com>
In-Reply-To: <20251118065817.835017-5-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Nov 2025 09:44:26 +0100
X-Gm-Features: AWmQ_bkN5pSjhIhl1KBHBuy1-lXcrkuRFvZ19o-iJjMH1c5og9fONsT5dCVU14g
Message-ID: <CABgObfZfGrx3TvT7iR=JGDvMcLzkEDndj7jb5ZVV3G3rK54Feg@mail.gmail.com>
Subject: Re: [PATCH 4/5] i386/cpu: Support APX CPUIDs
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 "Chang S . Bae" <chang.seok.bae@intel.com>, Zide Chen <zide.chen@intel.com>, 
 Xudong Hao <xudong.hao@intel.com>, Peter Fang <peter.fang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 18, 2025 at 7:36=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> APX is enumerated by CPUID.(EAX=3D0x7, ECX=3D1).EDX[21]. And this feature
> bit also indicates the existence of dedicated CPUID leaf 0x29, called
> the Intel APX Advanced Performance Extensions Leaf.
>
> This new CPUID leaf now is populated with enumerations for a select
> set of Intel APX sub-features.
>
> CPUID.(EAX=3D0x29, ECX=3D0)
>  - EAX
>    * Maximum Subleaf CPUID.(EAX=3D0x29, ECX=3D0).EAX[31:0] =3D 0
>  - EBX
>    * Reserved CPUID.(EAX=3D0x29, ECX=3D0).EBX[31:1] =3D 0
>    * APX_NCI_NDD_NF CPUID.(EAX=3D0x29, ECX=3D0).EBX[0:0] =3D 1, which
>      enumerates the presence of New Conditional Instructions (NCIs),
>      explicit New Data Destination (NDD) controls, and explicit Flags
>      Suppression (NF) controls for select sets of EVEX-encoded Intel
>      APX instructions (present in EVEX map=3D4, and EVEX map=3D2 0x0F38).
>  - ECX
>    * Reserved CPUID.(EAX=3D0x29, ECX=3D0).ECX[31:0] =3D 0
>  - EDX
>    * Reserved CPUID.(EAX=3D0x29, ECX=3D0).EDX[31:0] =3D 0
>
> Note, APX_NCI_NDD_NF is documented as always enabled for Intel
> processors since APX spec (revision v7.0). Now any Intel processor
> that enumerates support for APX_F (CPUID.(EAX=3D0x7, ECX=3D1).EDX[21])
> will also enumerate support for APX_NCI_NDD_NF.

Please just make the new leaf have constant values based on just
APX_F. We'll add the optional NCI/NDD/NF support if needed, i.e.
never. :)

Paolo


