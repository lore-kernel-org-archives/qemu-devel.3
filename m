Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4082D2127C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1OfA-0002J5-Tb; Thu, 17 Oct 2024 07:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1Of8-0002Im-SD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1Of6-0004op-PK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WxwWYReb1MGUsBhi3qCU56PpwRxbBB4Fpo2FhE635i4=;
 b=H/O8bnGcaIW63+QXE1qcV8wBAREOnEqv1C0eXpt6aj56aAUST75myMtuPG24Uhg1c/9EE3
 Fowg9bH/3hKqE5/SfxWCP2UKWXd+J7A7GbobChKf1aJfIQ9JvBjZLcM4dHHhxUlZ+QHjvi
 WVyNxEaTgH4nChm2SKmBe3DG8NQs17k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-ECS0ZVYSPgGzYP_lKNtnLA-1; Thu, 17 Oct 2024 07:27:19 -0400
X-MC-Unique: ECS0ZVYSPgGzYP_lKNtnLA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d67f4bf98so453823f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 04:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729164438; x=1729769238;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WxwWYReb1MGUsBhi3qCU56PpwRxbBB4Fpo2FhE635i4=;
 b=qq8V3aERRXRUH0p4AERGLbHFRvm8QMxBv0i3WYMN9bcVcuN9wjHVy6V8Aqy5Q5IH91
 QuoFXzWG8TbHEldA4wwMtQ66x7UUifTqpORwKvvUu2n/zePs7Smgo5e88elafGPK1EKC
 s1+2nAcWdr6VzPoy1EG/iy3UEUZaA3daktBN53p3Pom5uqSaKxHqwCuV0gGSqSmQUXW0
 JOvwFFYzbLqKwT7kkOVkwWimllv7rbTWbGYGPJdEZagpoV7GBezSogKxNG4QVRg4MmcU
 xWD46HUURDRTUkpO44XPo91BaqTTfvGshbGK3KHJOJkBGuMsXC5bXiyncEJzFRkomEV3
 8oRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaJl3CzFi6OmNWDl/UYSj4XwZydCaNDqcEjBXmwr54/Bg0v8/1dsbKhdnidwymYMvsuqvuex/CnFIq@nongnu.org
X-Gm-Message-State: AOJu0Yx2qj5pthmELVPk+yysr9QCR5yfe+GJXAbxsxjVa+eovBU4jgqT
 frXLuqTkHQVA+HkeZPlr46uIiN8h07O4a0qM5FEP/r2UKoemFj+rncFHnripKWmsNM/HVu51Pi6
 dIK+ioApJzv6rQeSMfiTYSUy/dueOijge89r4veehUxgkNVBbc+KesTC1V9SMUUw=
X-Received: by 2002:a5d:4a06:0:b0:374:c8e5:d56a with SMTP id
 ffacd0b85a97d-37d86d68ee4mr4618044f8f.48.1729164437775; 
 Thu, 17 Oct 2024 04:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvYCtC1tL/2mEtI7wR7cJFqDHfo9GBc63xE8QEKnEeRJf/fpjXLAuT8tbwnbmOYb/gJqfOXg==
X-Received: by 2002:a5d:4a06:0:b0:374:c8e5:d56a with SMTP id
 ffacd0b85a97d-37d86d68ee4mr4618032f8f.48.1729164437393; 
 Thu, 17 Oct 2024 04:27:17 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c35c7fsm23128695e9.10.2024.10.17.04.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 04:27:17 -0700 (PDT)
Message-ID: <de5ab616-aa5b-4cb1-af56-1f4dc377b5f6@redhat.com>
Date: Thu, 17 Oct 2024 13:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/19] s390x: Rebuild IPLB for SCSI device directly
 from DIAG308
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241017014748.829029-1-jrossi@linux.ibm.com>
 <20241017014748.829029-17-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20241017014748.829029-17-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 17/10/2024 03.47, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Because virtio-scsi type devices use a non-architected IPLB pbt code they cannot
> be set and stored normally. Instead, the IPLB must be rebuilt during re-ipl.
> 
> As s390x does not natively support multiple boot devices, the devno field is
> used to store the position in the boot order for the device.
> 
> Handling the rebuild as part of DIAG308 removes the need to check the devices
> for invalid IPLBs later in the IPL.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ipl.h              | 11 ++++--
>   include/hw/s390x/ipl/qipl.h |  3 +-
>   hw/s390x/ipl.c              | 75 +++++++------------------------------
>   pc-bios/s390-ccw/jump2ipl.c | 11 ++++--
>   target/s390x/diag.c         |  9 ++++-
>   5 files changed, 39 insertions(+), 70 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 54eb48fd6e..aead1d6ae5 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -24,6 +24,7 @@
>   
>   void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
>   void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
> +void s390_rebuild_iplb(uint16_t index, IplParameterBlock *iplb);
>   void s390_ipl_update_diag308(IplParameterBlock *iplb);
>   int s390_ipl_prepare_pv_header(Error **errp);
>   int s390_ipl_pv_unpack(void);
> @@ -65,7 +66,8 @@ struct S390IPLState {
>       bool enforce_bios;
>       bool iplb_valid;
>       bool iplb_valid_pv;
> -    bool netboot;
> +    bool rebuilt_iplb;
> +    uint16_t iplb_index;
>       /* reset related properties don't have to be migrated or reset */
>       enum s390_reset reset_type;
>       int reset_cpu_index;
> @@ -172,11 +174,14 @@ static inline bool iplb_valid_pv(IplParameterBlock *iplb)
>   
>   static inline bool iplb_valid(IplParameterBlock *iplb)
>   {
> +    uint32_t len = be32_to_cpu(iplb->len);
> +
>       switch (iplb->pbt) {
>       case S390_IPL_TYPE_FCP:
> -        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN;
> +        return len >= S390_IPLB_MIN_FCP_LEN;
>       case S390_IPL_TYPE_CCW:
> -        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN;
> +        return (len >= S390_IPLB_MIN_CCW_LEN);

Style inconsistency: In the FCP case, you did the return statement without 
parentheses, so I'd suggest to remove them here, too.

> +    case S390_IPL_TYPE_QEMU_SCSI:
>       default:
>           return false;
>       }
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index e56b181298..451f3b1684 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -28,7 +28,8 @@
>    */
>   struct QemuIplParameters {
>       uint8_t  qipl_flags;
> -    uint8_t  reserved1[3];
> +    uint8_t  index;
> +    uint8_t  reserved1[2];
>       uint64_t reserved2;
>       uint32_t boot_menu_timeout;
>       uint8_t  reserved3[2];
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index aec79f41a8..50fde05b67 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -448,7 +448,6 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
>   
>   static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>   {
> -    S390IPLState *ipl = get_ipl_device();
>       CcwDevice *ccw_dev = NULL;
>       SCSIDevice *sd;
>       int devtype;
> @@ -481,9 +480,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>               iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VIRTIO_NET:
> -            /* The S390IPLState netboot is true if ANY IPLB may use netboot */
> -            ipl->netboot = true;
> -            /* Fall through to CCW_DEVTYPE_VIRTIO case */
>           case CCW_DEVTYPE_VIRTIO:
>               iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
>               iplb->blk0_len =
> @@ -508,6 +504,17 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>       return false;
>   }
>   
> +

Remove the additonal empty line, please.

> +void s390_rebuild_iplb(uint16_t dev_index, IplParameterBlock *iplb)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +    uint16_t index;
> +    index = ipl->rebuilt_iplb ? ipl->iplb_index : dev_index;
> +
> +    ipl->rebuilt_iplb = s390_build_iplb(get_boot_device(index), iplb);
> +    ipl->iplb_index = index;
> +}

With the nits fixed:
Acked-by: Thomas Huth <thuth@redhat.com>


  Thomas



