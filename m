Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6291C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 06:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu3Zz-0007zc-7a; Mon, 17 Mar 2025 02:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu3ZO-0007wd-F8
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu3ZM-00046g-Sm
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742191402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZdFajaLTZczCh5Xi/1eTDUxNYxUBo2oJ1/PS5Agr430=;
 b=HVCYpAuWybiWQZw6nJVaI/KAOM9H+VI8hjbV6rqSSHdfcZOi5PdQEougD2GE/bx4UOJnqT
 pVTQxrQYEhcjpqm7t5g4BZQBimHtof8gAD67DDfsjSxaZSxdS7MIQI1Sh59XnO4lNYsUb5
 q8HnafIPYA5V51CNhbze+lWPxTT28zU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-SDlnesg_PdKrBV9qBJ2csQ-1; Mon, 17 Mar 2025 02:03:20 -0400
X-MC-Unique: SDlnesg_PdKrBV9qBJ2csQ-1
X-Mimecast-MFC-AGG-ID: SDlnesg_PdKrBV9qBJ2csQ_1742191399
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39130f02631so1900018f8f.2
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 23:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191399; x=1742796199;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZdFajaLTZczCh5Xi/1eTDUxNYxUBo2oJ1/PS5Agr430=;
 b=JTpj7xKdAZXSKQr089Z/IYeeH6d0f0XiGxCJe8hGvSYpvLr94SpajXr0FQW6G/m1Se
 xY43Dj0JEJvjiz969AEi4Vha3yQFq5dk5KRb3yqr3S0Fxu5I0yd6a721UgvU1JsLf5B+
 +kOc+7jjTd4Dh2Uc0hjBpwkCzF8OOMUoTTsNuUgOqRhQ/myWeBb2gC5j5VnGAot7zEa2
 dQ6EsaExrM+UHpmYM/BAEyx6C99WFOSyfUcC5xSs4pQW+g8IwEA+mUnqwaVkR5sqUVb1
 Yg4802OPKOHPIeP1Swvf1AtytrJsWR1akfpY9L9/eBeE96U68qP2p9PMnKdHOCTKTwMt
 KSig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD+2m6CpjoXnZC3exIzTNKtm4EwrR8/yldFv6AFBH1aucnF6ywkYVyvR9M5p49I8Js8AfDZ+VbarR9@nongnu.org
X-Gm-Message-State: AOJu0YwyZ4k1J0/0OJ0X38Tc9vLVYrGAQlNsjmzJzS+K95Gk+DiMWuzV
 EqHr94mEZJFOmwrs4JX7uTRCE01Cj2mGHsZhtUTqmSWKW9NdN52bdgX+ep1RRuz/ZQdKTZQ/BJK
 brS5b4KFmWaHsiPIA7E4pu+Eqkmw8NFTjmtDnLUIP31URpTpJiKVn
X-Gm-Gg: ASbGncs48B+7wcJejlNksejOLioLUCAv/AxexZXIQPbY9vflgmffn7gsX/ReQhryR1t
 nK9nW68aw5u4GLwYC4pYeIy9OiLxVxw5Dt4X5hxjz2xTQk7/eqStgsuNebMRiZ9bBqCoO+aoFiO
 u9Ssa/+3YSM+YwFpPstGdWV5i3gjgSP5jer8gp2h/BoMqGUiOIJnhYIy346qIDHlyGIp9DhPUdB
 T1uzMH8+iqtP33DLfcidJh4AETPio/vTwA9vnL+QOE2Kge0XWsqSNfL3BLNqU70MBmevzxvJsuQ
 GG270gmCoJKTx9OAI6Gcxf+p1b2qztoUGVIy/3UORLZ1VMM=
X-Received: by 2002:a5d:6d8f:0:b0:391:48d4:bcf2 with SMTP id
 ffacd0b85a97d-3971d5227d9mr11302158f8f.12.1742191399064; 
 Sun, 16 Mar 2025 23:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2ltEpRJB3Zp9UKWT4XUnZFJ45Ah03h/gLW4EvfnFLJT3UZtbMoVvwjbmvcvFd7LlsraBAcg==
X-Received: by 2002:a5d:6d8f:0:b0:391:48d4:bcf2 with SMTP id
 ffacd0b85a97d-3971d5227d9mr11301947f8f.12.1742191392486; 
 Sun, 16 Mar 2025 23:03:12 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea16csm13771756f8f.82.2025.03.16.23.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Mar 2025 23:03:12 -0700 (PDT)
Message-ID: <a1991d55-95f9-4c1b-9977-cd40e566acec@redhat.com>
Date: Mon, 17 Mar 2025 07:03:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Broken NetBSD Orange Pi image URL in QEMU tests
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
References: <CAJSP0QWKnLDsVUbqO_kNB7GiZPU0-YpOU8T4BNCgyNBi54dtDQ@mail.gmail.com>
 <12d09c42-e6b2-49d1-9b06-e5a26acc2c5b@redhat.com>
 <CAJSP0QUWkeaSsVmdfrXNAaSqB_uMUxqAD+GR7Xm4FHEgwYArNg@mail.gmail.com>
 <CAPan3Wozs=BX2pYxgBR3R_TtV75Pk8T=TNXZjgRHajzYw47Y-A@mail.gmail.com>
 <CAPan3WqR_UmrJMtYEe02K6vKy4joNE5frGDMW1KWFH-so24nbw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAPan3WqR_UmrJMtYEe02K6vKy4joNE5frGDMW1KWFH-so24nbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/03/2025 22.01, Niek Linnenbank wrote:
> Hello Stefan,
> 
> As of today, it seems the URL is working properly again. I've done a few 
> downloads without any error.
> What I did notice is that NetBSD provides a 'cdn.netbsd.org <http:// 
> cdn.netbsd.org>' also, but I can't see any noticable difference yet.

Oh, weird, in commit 380f7268b7ba4a6 I had to switch the URL from the cdn to 
the archive one since the file was not available on the cdn server 
anymore... but now it seems to be back! Certainly something to keep in mind 
in case we face problems with this asset again.

  Thomas


