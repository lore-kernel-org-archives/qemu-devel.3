Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AC7E6895E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 08:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Qnx-0005yI-Jk; Thu, 31 Oct 2024 04:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6Qnu-0005wS-0H
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6Qns-0001wn-8p
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730364315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iTunZQCEQuek482SfWvlvoEwwMzN073YT8GkBgCaI2E=;
 b=UEPZSa3TfCxbsOnBQtuczVwKKDbiAUpOfnWR9ieGOcc0zABpHaVLbedR/5I/hNOcBqXwLD
 m8gtiUJpVElFs0e6ueh17YTkwIO6cXtCULYdlbIxoQIhHa2CfCWHilu45tdgnTUcKrGmwv
 Z6TK7qDgbeSnBzpAj9NX5ew+rQm0ogU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-RiIVNMvVMiuehp-VAtbrIg-1; Thu, 31 Oct 2024 04:45:10 -0400
X-MC-Unique: RiIVNMvVMiuehp-VAtbrIg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d95264eb4so378820f8f.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 01:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730364309; x=1730969109;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iTunZQCEQuek482SfWvlvoEwwMzN073YT8GkBgCaI2E=;
 b=RNFl/5PxyAjizJWGFXrKM6DsE46023B5wmT5WMM2L8zgRgBwg3QY0aBVp2UVOQuvBv
 9FDMzOt0ONlzKe/SHVXYcCFi9c86JlxfVWFs65Pw6R5Pb7BpY/QJjzap0ZsnzjyjzwKR
 dF2HFzgedXrndokKbeUDLCo65eNWBIArG3YqsB9uCXF1+4w+5zTsbnKtqkKhIhP9yp/R
 /962jgoiN5x1E73khVR9Jz361MZ9y8TNk1/5UOk7Ou3AYojcT5ZAW8vlurxS1fXHcYHT
 fH9tvhcU33Nu5XLd3j6pOZm9fuz0Ww++b92SIfs0OwU2e5jLn1xtKq09Sic2UXlpz5JA
 2Miw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURQFIGagitVgKV0TlYLzBMK37aF4DFslPFXUMKJX17dFmIPCoaQs+y+l8hVNE6FsUBY4Jud9kWgJ5B@nongnu.org
X-Gm-Message-State: AOJu0YzAGpgfH72x/nYw+VDMGPs0B7sBv6TdkhgSlVriQM8lRPxaD3ae
 KDPCfV4rczW3gNiOvEkmu7ve2PJ7N42dH7p6o56AvLCsvwjOhyMKL9kCAFVy/q0vvVXn9ImlxJo
 kXsIhZCkTCHdh21srgkJdn6PGTR1vL1jMuK0tkXmxaFc4swRst44L
X-Received: by 2002:a05:6000:1863:b0:37e:f8a1:596a with SMTP id
 ffacd0b85a97d-381be76517cmr2054182f8f.3.1730364309451; 
 Thu, 31 Oct 2024 01:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHJCNI58kzqd13w+5KQ2Tml0WvT9hrbejzz3BtazM+5bSJ5xSWTd9vvpmTRQkjLrYqtSQ7CA==
X-Received: by 2002:a05:6000:1863:b0:37e:f8a1:596a with SMTP id
 ffacd0b85a97d-381be76517cmr2054153f8f.3.1730364308951; 
 Thu, 31 Oct 2024 01:45:08 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-251.web.vodafone.de.
 [109.42.48.251]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7a86sm1430269f8f.22.2024.10.31.01.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 01:45:08 -0700 (PDT)
Message-ID: <fc4fc429-6084-4b6d-aeb7-2948aa9df3b6@redhat.com>
Date: Thu, 31 Oct 2024 09:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/19] s390x: Add individual loadparm assignment to CCW
 device
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, Sebastian Mitterle <smitterl@redhat.com>,
 Boqiao Fu <bfu@redhat.com>
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
 <20241020012953.1380075-15-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241020012953.1380075-15-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 20/10/2024 03.29, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Add a loadparm property to the VirtioCcwDevice object so that different
> loadparms can be defined on a per-device basis for CCW boot devices.
> 
> The machine/global loadparm is still supported. If both a global and per-device
> loadparm are defined, the per-device value will override the global value for
> that device, but any other devices that do not specify a per-device loadparm
> will still use the global loadparm.
> 
> It is invalid to assign a loadparm to a non-boot device.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ccw-device.h       |  2 ++
>   hw/s390x/ipl.h              |  3 +-
>   include/hw/s390x/ipl/qipl.h |  1 +
>   hw/s390x/ccw-device.c       | 46 +++++++++++++++++++++++++
>   hw/s390x/ipl.c              | 68 ++++++++++++++++++++++---------------
>   hw/s390x/s390-virtio-ccw.c  | 18 +---------
>   hw/s390x/sclp.c             |  9 ++---
>   pc-bios/s390-ccw/main.c     | 10 ++++--
>   8 files changed, 102 insertions(+), 55 deletions(-)
> 
> diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
> index 5feeb0ee7a..1e1737c0f3 100644
> --- a/hw/s390x/ccw-device.h
> +++ b/hw/s390x/ccw-device.h
> @@ -26,6 +26,8 @@ struct CcwDevice {
>       CssDevId dev_id;
>       /* The actual busid of the virtual subchannel. */
>       CssDevId subch_id;
> +    /* If set, use this loadparm value when device is boot target */
> +    uint8_t loadparm[8];
>   };
>   typedef struct CcwDevice CcwDevice;
>   
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index fa394c339d..b670bad551 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -21,7 +21,8 @@
>   
>   #define DIAG308_FLAGS_LP_VALID 0x80
>   
> -int s390_ipl_set_loadparm(uint8_t *loadparm);
> +void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
> +void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
>   void s390_ipl_update_diag308(IplParameterBlock *iplb);
>   int s390_ipl_prepare_pv_header(Error **errp);
>   int s390_ipl_pv_unpack(void);
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 0ef04af027..b67d2ae061 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -18,6 +18,7 @@
>   
>   #define QIPL_ADDRESS  0xcc
>   #define LOADPARM_LEN    8
> +#define NO_LOADPARM "\0\0\0\0\0\0\0\0"
>   
>   /*
>    * The QEMU IPL Parameters will be stored at absolute address
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index 14c24e3890..230cc09e03 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -13,6 +13,10 @@
>   #include "ccw-device.h"
>   #include "hw/qdev-properties.h"
>   #include "qemu/module.h"
> +#include "ipl.h"
> +#include "qapi/visitor.h"
> +#include "qemu/ctype.h"
> +#include "qapi/error.h"
>   
>   static void ccw_device_refill_ids(CcwDevice *dev)
>   {
> @@ -37,10 +41,52 @@ static bool ccw_device_realize(CcwDevice *dev, Error **errp)
>       return true;
>   }
>   
> +static void ccw_device_get_loadparm(Object *obj, Visitor *v,
> +                                 const char *name, void *opaque,
> +                                 Error **errp)
> +{
> +    CcwDevice *dev = CCW_DEVICE(obj);
> +    char *str = g_strndup((char *) dev->loadparm, sizeof(dev->loadparm));
> +
> +    visit_type_str(v, name, &str, errp);
> +    g_free(str);
> +}
> +
> +static void ccw_device_set_loadparm(Object *obj, Visitor *v,
> +                                 const char *name, void *opaque,
> +                                 Error **errp)
> +{
> +    CcwDevice *dev = CCW_DEVICE(obj);
> +    char *val;
> +    int index;
> +
> +    index = object_property_get_int(obj, "bootindex", NULL);
> +
> +    if (index < 0) {
> +        error_setg(errp, "LOADPARM is only valid for boot devices!");
> +    }
> +
> +    if (!visit_type_str(v, name, &val, errp)) {
> +        return;
> +    }
> +
> +    s390_ipl_fmt_loadparm(dev->loadparm, val, errp);
> +}
> +
> +static const PropertyInfo ccw_loadparm = {
> +    .name  = "ccw_loadparm",
> +    .description = "Up to 8 chars in set of [A-Za-z0-9. ] to pass"
> +            " to the guest loader/kernel",
> +    .get = ccw_device_get_loadparm,
> +    .set = ccw_device_set_loadparm,
> +};
> +
>   static Property ccw_device_properties[] = {
>       DEFINE_PROP_CSS_DEV_ID("devno", CcwDevice, devno),
>       DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
>       DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
> +    DEFINE_PROP("loadparm", CcwDevice, loadparm, ccw_loadparm,
> +            typeof(uint8_t[8])),
>       DEFINE_PROP_END_OF_LIST(),
>   };

  Hi Jared,

while doing more tests with these new boot order patches, I realized that 
really *all* virtio-ccw devices now have a "loadparm" property, also devices 
like virtio-gpu and virtio-tablet, where it does not make sense at all.

Wouldn't it be better to add this property only to the virtio-ccw-blk device?

Also, is there a way to specify the "loadparm" property for virtio-scsi 
devices? It does not seem to be available for "scsi-hd" ?

   Thomas


