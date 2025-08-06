Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EC9C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 11:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujbwt-0007iN-2P; Wed, 06 Aug 2025 07:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ujbtH-0003H7-Q5
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ujbtD-00038B-K7
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 07:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754478056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CkOBpF8IywWwV+s7lNWGBx58ZPgGgcR2/YxAHFzpJbw=;
 b=T2gnlAvS8dzMbYWBqZ5gXSnuUIJrDFyFStedWn5IYDMZyltxDpLk3My8NUqpbDR5sEvG3i
 1hqEm8i2p5PzT8ohPMe8k9qRoNJT/IBVGcfu7CaHMdkCp79EByvn6kB7b8v+IgA8RZFbPb
 7hJRUN9Q3ctumY/X47kQeUF+pktYLrE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-pY56aP92MYOXu9EZlcUONw-1; Wed, 06 Aug 2025 07:00:55 -0400
X-MC-Unique: pY56aP92MYOXu9EZlcUONw-1
X-Mimecast-MFC-AGG-ID: pY56aP92MYOXu9EZlcUONw_1754478054
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-af93cf3fd41so80151966b.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 04:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754478054; x=1755082854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CkOBpF8IywWwV+s7lNWGBx58ZPgGgcR2/YxAHFzpJbw=;
 b=Gt0w1q8fBTvaVwZtuxJNiPCgU0X0g2C8HOhDwu6K264fx5NNc9WbRtAkhG7wEEvx5p
 FDPUe1EGV9d6PropRnda2yQH6wn5LLrRQ7bb8uEyKCDZgNdy/aVGZItbvMS0/p+v4jEM
 TJ9X1zhSMpvy+4QlrMpn7Td2Fmo6vSGqqutSs/tC9PDTHzE1QydSifctkiXd88BSspM9
 TsVoJ970+scTpsMsL3RTeoSddZmgzGxnaP3it8Xe31CKNts7bspGP98W0sy7szuTUStl
 vlVO8vWKksIRuZabB9kGyZ4MQn6HaqFiFotSRJSmgB/+BWgImRohqp9kupRJOEEBevkf
 q8dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyyShYr0FymWgZf0vofzcFVZ3Kg/k8XAyZ3/ja7sdHu52GvpllaGVShRUbVEE6+V674xj7vm2252dp@nongnu.org
X-Gm-Message-State: AOJu0YxzyfbqCErD9WdjJSivpR5RmVDhiETwTnhnRm7ghBUHv0YY4Dll
 ky/ZnG6ICmhrHUpS4C9do8Egw33QlfNXBMRj1rM+mn5QSZum11yykoi4sbCLTjW5KXdmhEhYSOj
 Vwr/NYIHksgTvO7/lpWRfl9Az7iC17op1b1nAYLbNJXU8W6lYCnBrRaHWvzZALCBSag8en0DTlC
 3TqCVP6KhZEpEgb9RCXBNPKbn2j3pmAP0=
X-Gm-Gg: ASbGncsHxsh5MGHxo0gBD8yfSaODdtYhSnQrsIc3F/51da7EChTgO4LCvQcd8P7NNCL
 4/XjdbYOnLqVoACja95g75vfUOgNLNsZ7s6GTrCGlVq4rg4iO5HkIqoLff0B0dRG9sMrE3B2Pwn
 gyuy+szMgkcptNzvw8sght
X-Received: by 2002:a17:907:6e9f:b0:ae7:f389:c751 with SMTP id
 a640c23a62f3a-af99054a1d4mr234980966b.0.1754478054154; 
 Wed, 06 Aug 2025 04:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH76GlLE4opXkR7iOgp7YJrXZIkkn6aI0bRMt8KOUBGg+x90cBx0leB/OQ/YTzjaQ58d7sxJm/NsC1GQYJKdZw=
X-Received: by 2002:a17:907:6e9f:b0:ae7:f389:c751 with SMTP id
 a640c23a62f3a-af99054a1d4mr234977666b.0.1754478053602; Wed, 06 Aug 2025
 04:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250802142115.41638-1-mjt@tls.msk.ru>
 <20250803085443.318611-1-mjt@tls.msk.ru>
 <7c282155-340e-44a6-9790-0a37f330eb30@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <7c282155-340e-44a6-9790-0a37f330eb30@rsg.ci.i.u-tokyo.ac.jp>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 6 Aug 2025 19:00:16 +0800
X-Gm-Features: Ac12FXyuAXibZ16WfUlsAfOw_U0qkF5atxOLBSs8T4ESe5f4unt4eQkaI32lzwQ
Message-ID: <CAPpAL=yXDh44BP+Z5KLXfqvzCos+xQb9PrLCPVtDEE6jYQmh3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] virtio-net: make VirtIONet.vlans an array instead
 of a pointer
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sun, Aug 3, 2025 at 5:51=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/08/03 17:54, Michael Tokarev wrote:
> > This field is a fixed-size buffer (number of elements is MAX_VLAN,
> > known at build time).  There's no need to allocate it dynamically,
> > it can be made an integral part of VirtIONet structure.
> >
> > This field is the only user of VMSTATE_BUFFER_POINTER_UNSAFE() macro.
> >
> > Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>


