Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B60C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFhN-0004gj-VM; Mon, 18 Mar 2024 12:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmFhJ-0004HT-I2
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmFhH-00051L-VE
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O45Q78VjajUmhNjZ9bxV6fifz/tZTUgcZtomuFaGtXo=;
 b=ZOr9+2WbNFQ8uq3F+sq9kov9tpcShIU4X8zm1w5bQfaMpYhg3BDvcNFAop+7XUpqqaXz9j
 FpIid18ZF2kL76N83/JiScq8cChwP7WCO5GiHouIABBAFehKYm14Dm6P3MXG2LpqX1BY0c
 NTAUHF5kUspLsolaE+11n81XX6Rvg0M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-0CMDQSwNOly2cvbYtFmXUg-1; Mon, 18 Mar 2024 12:18:45 -0400
X-MC-Unique: 0CMDQSwNOly2cvbYtFmXUg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-690ab2b0de1so13037556d6.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778725; x=1711383525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O45Q78VjajUmhNjZ9bxV6fifz/tZTUgcZtomuFaGtXo=;
 b=k1yXmczzWGfkLjLuabItcBD9oo9QWVZTMOUkHvgyHCwfF/pgAYvz4JeUW+f3XG2D04
 nhW64prOhBtUs5i5dGXrAdxP9kUYylyGT4dlNDeAlvtrnkLCoeMQoRuhxFIBEKiLMBu2
 AsGEzgpUX1zsIHZ/VS8F8DBRcg2Vxf59lBZrmHsC1SboCp4qUCMvZI2184+I50xVBAxV
 rZCpA6MsHPrqZnsg09zfOlnd6pp9g5aSbvwbmorYK2Vaiz+N4JpBR3qMnHeyA4e4iahR
 t1ToM87B9no/BDRP15gLoXqOhiTJE6MX85VC9/kbttNgFC/0NVDWmxwV2xX6qRhb4EXU
 Q6+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZBrRyQfGjhvlogLsJPg9IxcZCfkjkh/ReGHs9o3eMfa8ihMSCSSZIVaA/NW6YXnpvnsmx4cJN+x40XjvN9OoIh8k/UpA=
X-Gm-Message-State: AOJu0YxrcfJh4E4JfmlcmVx9bdureQqE2hLJRMaliPRxSr2Gwa6Oh5lA
 jtwFXUOpaEw3cLJ83n9xwL7WoQng5+lX8N+IcGt1DTZx04On9a5MM+7rC5x258E53PJUd81ahUF
 VQkMlX/Nk8K9IcED3eb+anI4lGV/77CUE+StmGtK10gxbUaSjJpCmkK1sx5nh
X-Received: by 2002:a05:6214:3b81:b0:691:402f:510a with SMTP id
 nf1-20020a0562143b8100b00691402f510amr14500120qvb.0.1710778724782; 
 Mon, 18 Mar 2024 09:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbRzv/hVoyy1LyRnGKHsxmDeohwenvD7dGt0D3rzIDvP5EC6H42MzxEayCO4v3ynAZFZL+LA==
X-Received: by 2002:a05:6214:3b81:b0:691:402f:510a with SMTP id
 nf1-20020a0562143b8100b00691402f510amr14500101qvb.0.1710778724342; 
 Mon, 18 Mar 2024 09:18:44 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 gs13-20020a056214226d00b00690f4a73726sm5349034qvb.61.2024.03.18.09.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:18:44 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:18:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] hw/usb/hcd-xhci.c: allow unaligned access to
 Capability Registers
Message-ID: <ZfhpYpHysSM1oA7_@x1n>
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <20231211071204.30156-3-tomoyuki.hirose@igel.co.jp>
 <CAFEAcA90fJgPGAjO0c4a=G+ge9bp1piVw40zt_rNHEoCTc_ngg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA90fJgPGAjO0c4a=G+ge9bp1piVw40zt_rNHEoCTc_ngg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Dec 11, 2023 at 01:57:42PM +0000, Peter Maydell wrote:
> On Mon, 11 Dec 2023 at 07:13, Tomoyuki HIROSE
> <tomoyuki.hirose@igel.co.jp> wrote:
> >
> > According to xHCI spec rev 1.2, unaligned access to xHCI Host
> > Controller Capability Registers is not prohibited. In Addition, the
> > limit of access size is also unspecified. Actually, some real devices
> > allow unaligned access and 8-byte access to these registers.
> > This commit makes it possible to unaligned access and 8-byte access
> > to Host Controller Capability Registers.
> 
> We should definitely look at fixing the unaligned access
> stuff, but the linked bug report is not trying to do an
> unaligned access -- it wants to do a 2-byte read from offset 2,
> which is aligned.

IIUC the issue is the xHCI xhci_cap_ops defines impl.min_access_size=4.
Then it'll be enlarged to 4 bytes read on offset 0x2.  IOW, I think it'll
also work if xhci_cap_ops can support impl.min_access_size=2, however I
don't know whether that can be more than that register, so that the memory
patch is still a more generic approach.

Thanks,

-- 
Peter Xu


