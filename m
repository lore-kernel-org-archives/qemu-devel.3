Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65F606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JGa+eFIu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OErsuZNq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHQu-00041B-Kl; Fri, 23 Oct 2026 11:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xKHQr-00040i-Us
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xKHQq-0007Ro-Ab
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792770225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RZDrF/STdKxM22a3OUJ856ZVSv2vv/v8HMyfulYyZAk=;
 b=JGa+eFIu+aTCigq/i9J7bXduSnVc+3uljkcd2UNnqd2TbrF85g1i6hpe2fnY5VSWyu7yGq
 P+l/L0MlLljzNZkZhPerbqhRt0cxXWzNPmlNHU1NmmkS3zptnIQeyeuaYfY6l/T+k1FHyM
 uPVAABxbBdhYwiu8k/+5SLrzJ24eRFY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Ctzm33BxOK264Hic7khN6w-1; Fri, 23 Oct 2026 11:43:42 -0400
X-MC-Unique: Ctzm33BxOK264Hic7khN6w-1
X-Mimecast-MFC-AGG-ID: Ctzm33BxOK264Hic7khN6w_1792770222
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e95f8543c9so8821695ad.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792770221; cv=none;
 d=google.com; s=arc-20260327;
 b=eGj4MZIIEPmjCgOBWHtu08WxG7lWELsTyyXZzF8BzdXTE5Ryf3FNdk15s2XRXKos/B
 3D2ZVZYBlRIA1t2NnsJgDBDoeDqffPBuHxL3g7QmIOmgKSRr3lh6lkSWxypXYy8W5rZh
 q4XUg3QJKPDZ1Riw6omMfrR3Zb3H4A0nVUu8PQ/YLqM/UuIEjcQKu6GLFo3B8u4cdfK2
 7bl1duk/8WaDNzTI/nkrbVB24rA+L8O5RwgS56fZhUbcWzGVXU0h8QcaZquT81EhdoiY
 bhaR7Mudu7TTjABMTnCcGs3DiThx1KuiENUEzE+/+nKYPJP773whRCAe83S7WOO9+pjg
 M/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RZDrF/STdKxM22a3OUJ856ZVSv2vv/v8HMyfulYyZAk=;
 fh=sfxyHXhiFTm4J7ObEFlfg5a0OnE9yk/ZtpXMrB1wjpY=;
 b=WArgLLQGJggaVZNDGt7gAeiG9wLwP8rF2IUqCxG3yytOTJdihP4XX78UeipDmuwTgV
 /Mlj/cDQohG+WRFpeUMBKjwnvjIBxsuXo8EnG8HfgtCKfAAgLcrOZpfr/aABB8gSos77
 r0/VsAi/9qaj/iEG1pDtPySCuSP4DQJeYtyVmPpoYZOMZKHmu3tKiFqO4dFDOkNFSeme
 xg68ARHaeGPOwXhFuKrcoaCDSsQHCFY65XwOFF/0c5k/vyAuRj4WlYxdPB5q75VE12El
 eO1ywxQBWTWoaoRdeaC8iQLSAfRkvt6CMX88LmM6YaXLBBoq6DXLi7/csLe08udZx36U
 tyag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792770221; x=1793375021; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RZDrF/STdKxM22a3OUJ856ZVSv2vv/v8HMyfulYyZAk=;
 b=OErsuZNqcM5FDfY7P87USVdAvHSGE4aRNNYZCPqlpBZtC8KQ3RhrKibl6gxRfU3G6Y
 TBOt7wn+WPEpoziea8xbxA8v2+egx2vVzNVuD+TdsH7lNL1WST3RkInaqUEyxmCn4Kcn
 yXovC4Qk9SQdI4yF7wrE0ShTEUqJKBEwCPEv8pzweGZ4BNnUWDnSZQpsMg6ApUkyPMgY
 NJZ/Dr8V70grk2K/svOJ77ttcXKLxG60PyJyN8UYglSnYy1S7dlMGD6MLZ7i70P+MAsz
 4LyTnDZOWjAZ2rkVoNUP1Nucgm96LGZ6A45fXcuplMauHeCCugFIJ8m05viP2OQdzpEM
 0vKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792770221; x=1793375021;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RZDrF/STdKxM22a3OUJ856ZVSv2vv/v8HMyfulYyZAk=;
 b=B/BhnTM9AouHDpTuqdrVe+MR/3tdlM3tkL1BvNcpGXPnF9xDNqRRb6hX9new9eGBTF
 vPxcWXBdPZXvk48tqXaHsTn34ZHi9vDxfaGGKWUslLWbBRSF76Jru6hff5Vt5XTYpXdg
 Vn0AMTZNo1ZpELqkh5wY6rISMnLbTRj64oV7nRwPt0HAIOyCOOY/1oIfXrAaVhyfIbQ1
 01Seg/BRQg6SwgEMcx6EuglVCT6c5AF+2vUglnzCrhsWrgztUniDLC0grQcuBjP8afXf
 dZWHUFe3ekt/aYYvM8q8wwyuyaIJD9BbJRJibQwfQ8sWp2cMC2KGlAQNdFT3k+OjjMNx
 P4Ew==
X-Gm-Message-State: AFq9FYKSIYXwDGjteGdX8LCPlaqo+fwIZxfodclLc98Yqg332SfDMfxg
 eKyj5WyErhrqtr8TQFVqrGvt2EB8qyVYcaTnWalMmJxjztXsmGUvLi4gE1+blBdKaRGLg98L0xk
 4xlUUuoTjg+Gdp15pI5qH44ShDGfRhlAnIfy9AWd4YSyyYVDot8aR2XBwGfKX4ehTOc2QQbP8tT
 mGFdzY8KuxOWDBU5TU2uWCTuPTuiaDd8Y=
X-Gm-Gg: AYBFou1Fyx6TIaTqXzfSf4cvs02qiw81yixHMMeVZSZQsEcf/mKkUEwKcNQ0CoCxlqI
 bWvQ0+SCiGNfg6AJo50TGatpvZKxCBoILIvsvvGkq170O7He/wH9CZx1sq7d9G75R6P8Q7JMs9C
 TiApEdc8LycA4O2r75wP96F1EAbqtcnmx6DDWXsa5FW9IQvjrQKHrm/PY=
X-Received: by 2002:a17:902:fdaf:b0:2e9:3ff7:b0ec with SMTP id
 d9443c01a7336-2ea7bc72041mr28967075ad.1.1792770221489; 
 Fri, 23 Oct 2026 08:43:41 -0700 (PDT)
X-Received: by 2002:a17:902:fdaf:b0:2e9:3ff7:b0ec with SMTP id
 d9443c01a7336-2ea7bc72041mr28966875ad.1.1792770220808; Fri, 23 Oct 2026
 08:43:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023152357.1614817-1-peter.maydell@linaro.org>
In-Reply-To: <20261023152357.1614817-1-peter.maydell@linaro.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 23 Oct 2026 17:43:29 +0200
X-Gm-Features: AclHuK_UJGW2BeXgqrStfsE3DuKYAsRCu75yc59p-G4HGnan6kva6dOC1pAvGAM
Message-ID: <CAGxU2F74osfvMAX+Og4g0ZBcfYRJcP1mNnY4rTiS3OR0zX485g@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: Don't complain about spaces before
 Fixes tags
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 17:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The checkpatch.pl script insists that Fixes tags are at the start of
> each line of its input. Although this is where they ought to be
> in the commit message, it is not where the script will see them
> in common usage patterns like
>
>   git show <hash> | ./scripts/checkpatch.pl -
>
> because 'git show' prefaces each line of the commit message body with
> four spaces.  Allow spaces before the Fixes tag; this matches how we
> check for e.g.  Signed-off-by: tags.
>
> Reported-by: Stefano Garzarella <sgarzare@redhat.com>
> Fixes: 910e1d41be6b2 ("scripts/checkpatch: validate Fixes: tag format and commit ancestry")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I just ran into this myself today as well so wrote up the patch

Thanks for that!

Tested-by: Stefano Garzarella <sgarzare@redhat.com>


