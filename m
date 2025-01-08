Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F28BE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVYWy-0002iD-E1; Wed, 08 Jan 2025 11:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tVYWw-0002hp-H8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:03:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1tVYWu-0007hu-U2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736352214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMeo4wUs2k29nje4o0WwXIj9r8ApTftux0tZoTvXmZo=;
 b=TQ/Z79+gcjM5gp+pM6PHjEYhgHdfjQcHfux8J7LwLAGa1Pi4oiIwmrCZUqmhuSy45dhg8l
 bUfEK61buv6YvkvTKWnW5+mSxJWHqZDV6dpWGrUlFor/tGPSQC6jP0ZYh0iuM46pmM+voO
 BXEYPMM6lqdzxijaDL4hQR/MNNp2eRI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Aw8SlpoXNFOd9-34AXmkng-1; Wed, 08 Jan 2025 11:03:33 -0500
X-MC-Unique: Aw8SlpoXNFOd9-34AXmkng-1
X-Mimecast-MFC-AGG-ID: Aw8SlpoXNFOd9-34AXmkng
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8844560e9so372240006d6.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736352213; x=1736957013;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hMeo4wUs2k29nje4o0WwXIj9r8ApTftux0tZoTvXmZo=;
 b=wx6jbx8qcKAo6Zy/lZTVU3DaynD41JkwhbilzbegdEIl4KIt0COZFPBiyr3IPn/t+8
 oBqOzmO9nq6GXYL1LR4q+mg4ff7mkNiVM20QmablwIwLsZiLvm5JyiKJ3+g2Knrindr6
 SkE5JZTRXgVJaNbkpqU+0xNxph+K5b2nqImbY+TeF8UKAabnFV9c9Lp6DLdWaB0GK1WU
 /jWu3/cMmZwxzlSR2xrIG50Bmy+tnpiDiLpsrTwa/SoMCZh8lbz95lNSA1M+EhcAJ4l0
 9pdemJAWARYtA+xZkVEfe9lD1SVA0y9HBgyJpPUUxmTB5D5XDTN9I2k5BlWYpSGkmUU4
 3LaQ==
X-Gm-Message-State: AOJu0YwdaHrjl++hF9hsffORNKuI9xnyr8jy1cPazzE4INNpgdoydERc
 8G97o83vt8HfgIqRm2nAh/4k6mD/A3xchrWNiCTXnzNkL3magPWiDmFHV3VC3TiHR1wADPmBDWo
 ethtTxBpzbgPLfaigy4SlZ2B8ht3b9M66s0dj/O9A4OhiKjLFggye
X-Gm-Gg: ASbGncvjBk7Vg5HpuunaKCerptFIaZ2SAcu7s/mKAKkasTE+5FFfhtxC02w3TTg65Df
 owy1jusSxhe6uj6FjfD1y8XwbsrbVe+sjmF3aD4ZuxB98hihwE7LoFIdqKTqo7aKkSd3a41h4j7
 umubWYdsdQ0fkESllMdVRGG08/3xcP1Lv0K3/jb5N2v88QL0pzMoB2NfQhwk3hTAg6xs0Aoc5Oy
 Gbrjb/IwS4wLIfXYNkQeSwKD2bILIWf/ZFAAAhLe+miYRa32r8=
X-Received: by 2002:a05:6214:53c2:b0:6d4:85f:ccb7 with SMTP id
 6a1803df08f44-6df9aef1beamr58553126d6.0.1736352213073; 
 Wed, 08 Jan 2025 08:03:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQLAOdakvKUu05Ks+U5rWndX4ZxqYMbjZ5xRvSVM/znjWY8jWfSuFxIw6v2QTUbgmtYnPXng==
X-Received: by 2002:a05:6214:53c2:b0:6d4:85f:ccb7 with SMTP id
 6a1803df08f44-6df9aef1beamr58552626d6.0.1736352212717; 
 Wed, 08 Jan 2025 08:03:32 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d283bsm191293866d6.101.2025.01.08.08.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 08:03:31 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Philippe Mathieu-Daude <philmd@linaro.org>
Subject: Re: [PATCH v4 0/2] vpc: Read images exported from Azure correctly
In-Reply-To: <20241212134504.1983757-1-vkuznets@redhat.com>
References: <20241212134504.1983757-1-vkuznets@redhat.com>
Date: Wed, 08 Jan 2025 17:03:28 +0100
Message-ID: <87cygxb8dr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Changes since v3:
> - Split the change into two patches [Philippe Mathieu-Daude].
>
> It was found that 'qemu-nbd' is not able to work with some disk images
> exported from Azure as it uses a currently unknown 'wa\0\0' 'creator app'
> signature. QEMU currently supports two methods for determining the image
> size: CHS and 'current_size' and the list of known 'creator app's is used
> to decide between the two. Invert the logic in QEMU and make 'current_size'
> the default as it seems that VPC and old QEMU are the only two legacy apps
> where preferring CHS makes sense.
>
> Vitaly Kuznetsov (2):
>   vpc: Split off vpc_ignore_current_size() helper
>   vpc: Read images exported from Azure correctly

Ping?

-- 
Vitaly


