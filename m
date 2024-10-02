Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC825CF31AF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwYR-0000Mg-T9; Wed, 02 Oct 2024 06:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwYL-0000ML-HB
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwYJ-0000Wf-Rn
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727864750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XMwMtz76lfJcPKySIzdnPKszxiHpDniIFN0UI66uwGE=;
 b=ah5ddOroFfwElnQr37f2W7rE1eWJVwFx9yJW94Xvgpbo4/AgvgEXA51BFGVFHUGGOv6OGb
 a6R9aEechh7tlUjn1U78FGE77BTLOwHgJ58b45c2W9Y37gAfpXG6QOzfPJ0d1kJYipWDt+
 Suk5T1Ub3A6mLDTAvgaHY2Y6d/4qOdM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-7J8Q0kVSNAil0j-Tftk5TQ-1; Wed, 02 Oct 2024 06:25:49 -0400
X-MC-Unique: 7J8Q0kVSNAil0j-Tftk5TQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb2c9027dso49781805e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 03:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727864748; x=1728469548;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XMwMtz76lfJcPKySIzdnPKszxiHpDniIFN0UI66uwGE=;
 b=LkZwI18rRaYrWs2m581PuM2+xkorbXDCiGGS8A9pSv5FZyucoILl5iKpthOMdiO5ps
 zCiU5RzK/eP7aOU6Gh9xjbmQQqrNp9egCEB4KdmJREfJRh1DNWG4dkEnUhsnj/wMwAxs
 +Rs/U972KWW7MfMraI4tumNbyM4YA7SA83we1xYFxf6yQD4DLtbxnlGlBJ+fI1NkErFD
 LdQO+1KDXKCBFsvf+NAp6A3soPMaqai100m/T6A/Fg8vuhLSs53iXju1/287Z884LTwG
 W2FAmrXtzUvI+D+DbxBazgrfRMRhg5wWPMRcTTcXdOIbNcBSGMXTHaR/zaraTg3hoRP5
 hsfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBdb7T5E53s10HtynY7FnFQ2tqZZBV2gJvozLcByvWiTbSGOcwzvaGY+adkHxNXfwQ1enHXGsXapFt@nongnu.org
X-Gm-Message-State: AOJu0YxpKaSbWkEYxyHubvVTt7IHdKLuidY0u7LhPOd8LDQfvYRyy8T7
 PhQwiqgXrtW1bHk8JpAfOmyb+O9vDIXl3lAnR1UXBSUtnstEw5vs5sv6k+X4K/Y3s8rQ5xu2oLn
 HVf9tmMya3l6pfQI6jeGdRnITfJRjOVNf8BnMKpVf0kJYVTPPag2d
X-Received: by 2002:a05:600c:3b03:b0:42c:b63e:fea6 with SMTP id
 5b1f17b1804b1-42f777ee31amr21694725e9.22.1727864748355; 
 Wed, 02 Oct 2024 03:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+jLvOZbOcEN+T8mygG4Xp+1ksnZoFvPLzjm0Rx8NQIi1TBH5V/5NqSM0WWZG1ZJ6kX9tmgw==
X-Received: by 2002:a05:600c:3b03:b0:42c:b63e:fea6 with SMTP id
 5b1f17b1804b1-42f777ee31amr21694565e9.22.1727864747907; 
 Wed, 02 Oct 2024 03:25:47 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79ff92desm14912885e9.40.2024.10.02.03.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 03:25:47 -0700 (PDT)
Message-ID: <408f72f4-4d18-46e6-9e8a-89542acaa306@redhat.com>
Date: Wed, 2 Oct 2024 12:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen: Remove deadcode
To: dave@treblig.org, sstabellini@kernel.org, anthony@xenproject.org,
 paul@xen.org, edgar.iglesias@gmail.com
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240917002212.330893-1-dave@treblig.org>
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
In-Reply-To: <20240917002212.330893-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/09/2024 02.22, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> xen_be_copy_grant_refs is unused since 2019's
>    19f87870ba ("xen: remove the legacy 'xen_disk' backend")
> 
> xen_config_dev_console is unused since 2018's
>    6d7c06c213 ("Remove broken Xen PV domain builder")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/xen/xen-legacy-backend.c         | 18 ------------------
>   hw/xen/xen_devconfig.c              |  8 --------
>   include/hw/xen/xen-legacy-backend.h |  5 -----
>   3 files changed, 31 deletions(-)
> 
> diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
> index 5514184f9c..e8e1ee4f7d 100644
> --- a/hw/xen/xen-legacy-backend.c
> +++ b/hw/xen/xen-legacy-backend.c
> @@ -147,24 +147,6 @@ void xen_be_unmap_grant_refs(struct XenLegacyDevice *xendev, void *ptr,
>       }
>   }
>   
> -int xen_be_copy_grant_refs(struct XenLegacyDevice *xendev,
> -                           bool to_domain,
> -                           XenGrantCopySegment segs[],
> -                           unsigned int nr_segs)
> -{
> -    int rc;
> -
> -    assert(xendev->ops->flags & DEVOPS_FLAG_NEED_GNTDEV);
> -
> -    rc = qemu_xen_gnttab_grant_copy(xendev->gnttabdev, to_domain, xen_domid,
> -                                    segs, nr_segs, NULL);
> -    if (rc) {
> -        xen_pv_printf(xendev, 0, "xengnttab_grant_copy failed: %s\n",
> -                      strerror(-rc));
> -    }
> -    return rc;
> -}
> -
>   /*
>    * get xen backend device, allocate a new one if it doesn't exist.
>    */
> diff --git a/hw/xen/xen_devconfig.c b/hw/xen/xen_devconfig.c
> index 2150869f60..45ae134b84 100644
> --- a/hw/xen/xen_devconfig.c
> +++ b/hw/xen/xen_devconfig.c
> @@ -66,11 +66,3 @@ int xen_config_dev_vkbd(int vdev)
>       xen_config_dev_dirs("vkbd", "vkbd", vdev, fe, be, sizeof(fe));
>       return xen_config_dev_all(fe, be);
>   }
> -
> -int xen_config_dev_console(int vdev)
> -{
> -    char fe[256], be[256];
> -
> -    xen_config_dev_dirs("console", "console", vdev, fe, be, sizeof(fe));
> -    return xen_config_dev_all(fe, be);
> -}
> diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
> index 943732b8d1..e198b120c5 100644
> --- a/include/hw/xen/xen-legacy-backend.h
> +++ b/include/hw/xen/xen-legacy-backend.h
> @@ -50,10 +50,6 @@ void *xen_be_map_grant_refs(struct XenLegacyDevice *xendev, uint32_t *refs,
>   void xen_be_unmap_grant_refs(struct XenLegacyDevice *xendev, void *ptr,
>                                uint32_t *refs, unsigned int nr_refs);
>   
> -int xen_be_copy_grant_refs(struct XenLegacyDevice *xendev,
> -                           bool to_domain, XenGrantCopySegment segs[],
> -                           unsigned int nr_segs);
> -
>   static inline void *xen_be_map_grant_ref(struct XenLegacyDevice *xendev,
>                                            uint32_t ref, int prot)
>   {
> @@ -70,6 +66,5 @@ static inline void xen_be_unmap_grant_ref(struct XenLegacyDevice *xendev,
>   void xen_config_cleanup(void);
>   int xen_config_dev_vfb(int vdev, const char *type);
>   int xen_config_dev_vkbd(int vdev);
> -int xen_config_dev_console(int vdev);
>   
>   #endif /* HW_XEN_LEGACY_BACKEND_H */

Reviewed-by: Thomas Huth <thuth@redhat.com>


