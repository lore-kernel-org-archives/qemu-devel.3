Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24849C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78iJ-0000zd-K1; Thu, 17 Sep 2026 05:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x78iD-0000zN-SI
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x78iB-0002wC-22
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789638440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NYdYCa9//EB/4wGZBCnRc+26CQv087qJNCJpCwVOUEA=;
 b=JhqC5GUEuC42r7abEZ//tXT0YgOy7STxKj3XVkygpk8qS7sWBjEIE+14v3+ThFlIfH5WAN
 kcYHRePraWIP9Aa0bBs3dG5/4E74eHCKFe6cYBhIDDr2QBmG89UNUjKy3heQwohdYRLfml
 EQ0EaK1V/o7JcyE1n4xdspFSeFKNLxo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-P_sFSA5WMwqH212-ZRIs-g-1; Thu, 17 Sep 2026 05:47:18 -0400
X-MC-Unique: P_sFSA5WMwqH212-ZRIs-g-1
X-Mimecast-MFC-AGG-ID: P_sFSA5WMwqH212-ZRIs-g_1789638437
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f6e8b5996so625503f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789638437; x=1790243237; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NYdYCa9//EB/4wGZBCnRc+26CQv087qJNCJpCwVOUEA=;
 b=SaujhYRqszyubm8xs6ls8rD+Lj6ke9FRsBk04tt9eAsKkykfzB2SZ9i0QNIPjOo5wt
 oka94vldi9VhJ1g1YXRi/YaEYO5iErqntKxHRuwj3qyPRiyqUU4ItUn1mlugv4Ah+JFG
 +c8VB9q6AcAHNMaEgl/NkeJfLHD7dPbViApvqhgRTXmzSUbxdKOrxQEG12QS1HlMX46l
 9lVPZh5iMlidpSJviVg3KEBtDuXIfdyNI+CleJoiI8RkWi/+uoZTsPbEYcIB/E1xzbL1
 nHJq3/7q3OiaS6AAIEs7uHkX/PPS+DwABBtLDVw8gvkxe7mcLwkGZWFHdHYJvbmHB+oS
 Ew1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789638437; x=1790243237;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NYdYCa9//EB/4wGZBCnRc+26CQv087qJNCJpCwVOUEA=;
 b=bLyl3aMTN2wr003GoNtQwN5gUuOQ9ygXaqkIfKwwegXGl1falYN9Bwku0vf9n+TOIj
 nLBRBOE4D5CUkApa+9ZjO2jsMSS9UzIOIaVy2LUOZ7qkpoONEr1j0h5K/hyA6J2eUi3x
 ZPmWM6WMgfA83Zd5t3bTMFbS7yZw/3fNBiBFQyljLu/mfiAbyLVByArUeimOYxPUtESS
 ErMO6y/kJi9o9DryOrJymTkIroCsOgEiGiF7qw4dZS0vlmrOcoiYcbSZv1KUW+U/Temp
 G+kmGEA6tbD5cZXdL3Vqvwl27wrDg4VXXHW1ZEXfNuXYhmFCSaqq6FB41hPzNFFkh9s5
 0JLg==
X-Gm-Message-State: AFuF++knmMVqQVFcoANbFPLuturWQ6Seb3CcSW3MZcJ1Xb2WoVf/8dj2
 25i+4PS84+p/CdVGrcJ6rHSnhtf8aF4pZsGZbQDkwTBPbxilcxauP893H+0k6s92Ykjmh29EOSI
 8DGcmg9FhyfEtygtuY4QUvY9z7Tg92QonntaaRPg/XuZSLafUmHxWdQkd
X-Gm-Gg: AYBFou3/4YwDRQy4QLsbrlavG8TFxzj34Hu9vpEyibNQIjHDEOYYV0yW2BGlSIaMY5s
 zZF2Z208DNpHdFtWsHFQOz5Kfd1jWJ7j1GqeT3wJjJs8/yEsiWBP81+1GtVLhsrDPyuT3DkCBjY
 UclBwlnmzyHNzAQ44ifc5+yRTDTJIoFYA4/L+pPW6B7VbOCWcnTwVnj4X7K1NcB5A3wLgforhp+
 hzeGMCOJ03IXpJEKSuo229eqJU7XlhPoEGgOzBbNEDu3Apl1XFlr2UoyKa8YNxlWNo9eYcNMsm/
 RM8J49SQlYJ7vWkdvzJTdzgX+2dodqc/nNK/2kog7I7aBFs24ENm8EVJc1uExUzQRqwE3zs0MnT
 pkgxKH2FQB3ob3vIp+9kS2PXPYfK6OMwcCBw=
X-Received: by 2002:a05:6000:41cd:b0:487:971:6b19 with SMTP id
 ffacd0b85a97d-4870d0667e3mr6946289f8f.36.1789638437464; 
 Thu, 17 Sep 2026 02:47:17 -0700 (PDT)
X-Received: by 2002:a05:6000:41cd:b0:487:971:6b19 with SMTP id
 ffacd0b85a97d-4870d0667e3mr6946251f8f.36.1789638437062; 
 Thu, 17 Sep 2026 02:47:17 -0700 (PDT)
Received: from leonardi-redhat ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27c65sm14642770f8f.21.2026.09.17.02.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:47:16 -0700 (PDT)
Date: Thu, 17 Sep 2026 11:47:14 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/uefi: add missing uefi_str_is_valid check to
 uefi_vars_mm_lock_variable
Message-ID: <aqu3FC_BrnHxgQcg@leonardi-redhat>
References: <20260916145050.1329206-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260916145050.1329206-1-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 16, 2026 at 04:50:50PM +0200, Gerd Hoffmann wrote:
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4213
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


