Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FE6CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 07:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svB9E-0007if-6y; Mon, 30 Sep 2024 03:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svB8p-0006Sq-KY
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svB8i-00014w-TT
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727682490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4iNNZrootspfg2gduT2ooCpydO7QcA9dvNd/l3Iqr+s=;
 b=FsTSkf26lREaJDpbpAeCeade4JANUkchlel5R5CO4wbAWPa+g/ZDP/1bPlvk+/zjC5YmUK
 8AYG88rh+Ok6kC483sLzYixvCerJZ+F4iXBiKoz3vlhgpr4/OG+IQX8FZpEV2XIzmL5FGy
 JbxCNNwQ44NgDqhkYoZ3oSDduyWtjZk=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-nlbZYI15N0yAURHDCwuHQg-1; Mon, 30 Sep 2024 03:48:09 -0400
X-MC-Unique: nlbZYI15N0yAURHDCwuHQg-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-507919285f4so543963e0c.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 00:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727682488; x=1728287288;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4iNNZrootspfg2gduT2ooCpydO7QcA9dvNd/l3Iqr+s=;
 b=jFMzQ/SovDFEOJ3P7EwdLGQ+J9aBGT2h7/p/qUsdA9iiX8CqM6bUZys9p0fqnv3Vfd
 /1UBv8sCv5418f0bfH3WLRMHw3SZGnF/2t3hJjhrLGHiqOh2Mvyaqpy7pEIeDEC4ORrx
 QQ3lc3XPVAu/qlmxTsu6SMYpRN7U9dcY0A+z9UdHjjL6JXdPtofZQ7yFuF4AxKFYF5UU
 7eFpMiKVd18zdcRYzpfQczbA5kkKKuDejwYQxSMR5h9QeUtrd2wcVWNgrZe+eu2P3CBD
 GsRedRKK+4rkHdcRD64Xkh1k2DydlULchWpCLjel6k2GAxcRL7xMScPbBNDWm3/O31bc
 5XtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHmK2IqXkSF5sL04UYxUtku5Cl69KPakXCxdkhTBjKfc1Ns0Z0g1HXQqsAqL18gnKO26M5t/cSb+5i@nongnu.org
X-Gm-Message-State: AOJu0YwHUmr2P1HzX8LTyUQq7SI1ZmgIjBMEKRvIg5PT0qkStmQ+HboN
 iwznWX/VTlF58xCQbzKNQLNFYiKWP4V6OQgUM1t5PQwbqHgQS062GdTd6aLnMT/hnHPHxh3ktpe
 FLVhP6QRwZybIwxTS9bXklz5cp2esdkwrom5WG35OuyK4zhwQU3btWdJPI1i7t9w=
X-Received: by 2002:a05:6122:3b17:b0:509:e278:c286 with SMTP id
 71dfb90a1353d-509e278c95fmr1694678e0c.6.1727682488588; 
 Mon, 30 Sep 2024 00:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhAxXf73J+XSxlewYkxcEe2F6/kvGHewHSA6VKy/xEudPbZZiImAbGnOKtk42SxDm+m2at7Q==
X-Received: by 2002:a05:6122:3b17:b0:509:e278:c286 with SMTP id
 71dfb90a1353d-509e278c95fmr1694667e0c.6.1727682488168; 
 Mon, 30 Sep 2024 00:48:08 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae37841796sm388002385a.111.2024.09.30.00.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 00:48:07 -0700 (PDT)
Message-ID: <f0d95299-48ca-4c23-bf68-dda8e499ad7f@redhat.com>
Date: Mon, 30 Sep 2024 09:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] pc-bios/s390-ccw: Remove panics from SCSI IPL path
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-10-jrossi@linux.ibm.com>
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
In-Reply-To: <20240927005117.1679506-10-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Remove panic-on-error from virtio-scsi IPL specific functions so that error
> recovery may be possible in the future.
> 
> Functions that would previously panic now provide a return code.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> 
> ---
...
> @@ -572,23 +575,37 @@ static void zipl_load_segment(ComponentEntry *entry)
>               }
>               address = virtio_load_direct(cur_desc[0], cur_desc[1], 0,
>                                            (void *)address);
> -            IPL_assert(address != -1, "zIPL load segment failed");
> +            if (!address) {

Shouldn't that be "if (address == -1)" or "if (address < 0)" instead?

Hmm, virtio_load_direct() seems to return an "unsigned long", so maybe that 
one rather needs to be fixed, too?

> +                puts("zIPL load segment failed");
> +                return -EIO;
> +            }
>           }
>       } while (blockno);
> +
> +    return 0;
>   }
...
> @@ -78,24 +84,30 @@ static void prepare_request(VDev *vdev, const void *cdb, int cdb_size,
>       }
>   }
>   
> -static inline void vs_io_assert(bool term, const char *msg)
> +static inline bool vs_io_assert(bool term, const char *msg)
>   {
> -    if (!term) {
> -        virtio_scsi_verify_response(&resp, msg);
> +    if (!term && !virtio_scsi_verify_response(&resp, msg)) {

Should that be "||" instead of "&&" ?

> +        return false;
>       }
> +
> +    return true;
>   }
>   
> -static void vs_run(const char *title, VirtioCmd *cmd, VDev *vdev,
> +static int vs_run(const char *title, VirtioCmd *cmd, VDev *vdev,
>                      const void *cdb, int cdb_size,
>                      void *data, uint32_t data_size)
>   {
>       prepare_request(vdev, cdb, cdb_size, data, data_size);
> -    vs_io_assert(virtio_run(vdev, VR_REQUEST, cmd) == 0, title);
> +    if (!vs_io_assert(virtio_run(vdev, VR_REQUEST, cmd) == 0, title)) {
> +        puts(title);

Shouldn't there be a "return -1;" or something similar here?

> +    }
> +
> +    return 0;
>   }

  Thomas


