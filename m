Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D744C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 15:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUSK3-00056h-1L; Wed, 25 Jun 2025 11:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSK1-00056S-Da
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 11:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSJs-0004Ne-Aa
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 11:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750866351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+lyKi4XBHGDSbK3UmgNeZlODsDYozuEN3Hh1wy9C8tQ=;
 b=HRXrw8Xag6LWP8gr5zbs9j44jv+nreONaBtkkF0+pxWhENR00XpQmjUGxKu0yHRqVqr5d2
 zOcsUntdoVNwe7YZObf4zf5UoFYAgRY91KR37t3iWDTGmgWwHwRJbQdVtaGCy+2rRXuBZU
 4ei5AKuNZYcSLa61HddnxVIj5VcfJr4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-1FGu0KFpNtWzNT24z5zupQ-1; Wed, 25 Jun 2025 11:45:49 -0400
X-MC-Unique: 1FGu0KFpNtWzNT24z5zupQ-1
X-Mimecast-MFC-AGG-ID: 1FGu0KFpNtWzNT24z5zupQ_1750866348
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so11246805e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 08:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750866348; x=1751471148;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+lyKi4XBHGDSbK3UmgNeZlODsDYozuEN3Hh1wy9C8tQ=;
 b=Of/IXTY9xFs4JVkpmdnomdljnB0EgXVg/tRTubk97X6Hbto1WCI0evb9PnHLVxy9z2
 g/cW9u3TBgVKTKISGcpPwjCnJdGboN/qlucCjERewMrF8cuHAQuBNbJj3zL0VgNY5L14
 rIBwUnACPOzL3pmFNAr9iOpbBbae7X/BcMuWXm5yU5xOQ7uDWds1gNbf0xg6A2HOPbjq
 5Y5RjswUsxZ4Narhv9uu0dNbJTjgDGGYO++3oxxJicRdcSJREmjgV5HXXeHL5Fk4bjoc
 T0isVQoqVcsHYojPWaEl+WRYkPsA4tJKyDllmVgq7egW7Kpxjsya7qDh5adGRHmfK57b
 eolw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/uUyh6Vni3mCbQIUFzYevPXXh3BC6CJSgOrYamKfvoOhO+DLg75C+TYASE8CsGGd795vVW+XKAXnp@nongnu.org
X-Gm-Message-State: AOJu0YwPVV+n0bH07IDx3xQnNI7qpK6LALonbsQIB2Q73zgV7ixD+Kvp
 SdOKMQCKiFthzP66s/NZ1C5p4HIINWj44OTt2DAvEMCkx2UPSSULQLZ+BcbYGhycBDGv0cMnSoI
 PB7RsEN29gMCkk7Iag6/vEOWHKKSh79wwEhb+OAII+mDxY4UkTCLTmVRrgYdMhun6
X-Gm-Gg: ASbGnctdCLvDLrxbQMU5gb2CEqNpMqABfnRm34Hoz5Fy591PzfCN5+8z1T3s0LBbjUY
 l7Zrm0OID6JPItC5ZtfKesQGHG1tlAmngm94O4+1aXViWdoeV/y8yBUfoU8hLVSJiknR9AK6dw4
 sA9UWjfgm5JvCOUcCI38j33H6jQRJf3P/Bp7f8rVVuQWDjieCSPXLGBO9SNFwTlbmzr4JgxoZ7r
 bKVyzAceFQZd61xiHDN+l9pEZMCGvZwNhR+tUE4icHmHzkkpcrVAHLwSBjShrjGMUus2yQMq8mm
 fHdoV2pJnxf85W8dKdujCzRcbskr7MVRcS4raiqceESn4PMBxvqBF25Qn4cLEFI=
X-Received: by 2002:a05:600c:4454:b0:453:483b:6272 with SMTP id
 5b1f17b1804b1-45381ab98cfmr34611325e9.7.1750866348118; 
 Wed, 25 Jun 2025 08:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN5Gzyi7uxYalmfI3BJCHwIAgsjlRbRdEYZVNJVHAndtbM9f5MRafkfmlUO3+GroDLnVcjjA==
X-Received: by 2002:a05:600c:4454:b0:453:483b:6272 with SMTP id
 5b1f17b1804b1-45381ab98cfmr34611015e9.7.1750866347681; 
 Wed, 25 Jun 2025 08:45:47 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823563fasm23296755e9.21.2025.06.25.08.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 08:45:46 -0700 (PDT)
Message-ID: <b5deb678-fcf8-494b-bc92-37ddbdfeaf20@redhat.com>
Date: Wed, 25 Jun 2025 17:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] linux-headers: replace FSF postal address with
 licenses URL
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Overall KVM CPUs" <kvm@vger.kernel.org>
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.02@sean.taipei>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250613.qemu.patch.02@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 13/06/2025 18.38, Sean Wei wrote:
> The GPLv2 boiler-plate in asm-arm/kvm.h and asm-powerpc/kvm.h still
> contained the obsolete "51 Franklin Street" postal address.
> 
> Replace it with the canonical GNU licenses URL recommended by the FSF:
> https://www.gnu.org/licenses/
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   linux-headers/asm-arm/kvm.h     | 4 ++--
>   linux-headers/asm-powerpc/kvm.h | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
> index 0db5644e27..a8bb1aa42a 100644
> --- a/linux-headers/asm-arm/kvm.h
> +++ b/linux-headers/asm-arm/kvm.h
> @@ -13,8 +13,8 @@
>    * GNU General Public License for more details.
>    *
>    * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + * along with this program; if not, see
> + * <https://www.gnu.org/licenses/>.
>    */
>   
>   #ifndef __ARM_KVM_H__
> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
> index eaeda00178..83faa7fae3 100644
> --- a/linux-headers/asm-powerpc/kvm.h
> +++ b/linux-headers/asm-powerpc/kvm.h
> @@ -10,8 +10,8 @@
>    * GNU General Public License for more details.
>    *
>    * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + * along with this program; if not, see
> + * <https://www.gnu.org/licenses/>.
>    *
>    * Copyright IBM Corp. 2007
>    *

This also has to be fixed in the Linux kernel first, otherwise the changes 
will be reverted when someone runs the scripts/update-linux-headers.sh 
script. Sorry, I should have mentioned that in the 
https://gitlab.com/qemu-project/qemu/-/issues/2974 ticket, but I missed it, 
sorry!

  Thomas


