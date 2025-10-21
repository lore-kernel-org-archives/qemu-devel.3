Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C62CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBD3e-0007EY-CL; Tue, 21 Oct 2025 10:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBD3c-0007CN-R6
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBD3b-0001AI-3X
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761055785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UIeI64CQMEQgHWP0mlkd/gF3ixj6/yAnEfWkau1bRXc=;
 b=Zdd9ZT0ssbLxMsRZVK43Jb0xQkLSNVigMKrMyUN28gpXVVW+XSx3HK/oNHPtGd4mvHb+Li
 MXsJunmY5YekfmuTMsqtTXluvlSEmRcet/ehuLw0tLX84P3LnPSshicMk2l/6PTMgFr55v
 JYQM62vqd5i10uCQiJBnK6XWhL1hM/o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-z4D7OJ3fPoWMUC8XRzbCjQ-1; Tue, 21 Oct 2025 10:09:44 -0400
X-MC-Unique: z4D7OJ3fPoWMUC8XRzbCjQ-1
X-Mimecast-MFC-AGG-ID: z4D7OJ3fPoWMUC8XRzbCjQ_1761055783
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-470fd5ba449so19097035e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761055783; x=1761660583;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UIeI64CQMEQgHWP0mlkd/gF3ixj6/yAnEfWkau1bRXc=;
 b=MNse1HA2q7AmcbtpEVntCkERkkInOxB1gBpi/tW43RIgQP15RNUtya8fTc9SqcBPfF
 Ynxa/GLgMsXi6LkGNoSeTnXlVvS8mS86E+He1i/rCPGY7IvdzgH8FKy8s7YK1vR46gj6
 ca2BX+Z2oKJ+Wgbu+E7V2ou1ZHBVjAPc/uduzcMGqZtv/89hnze35O/FK0hZxU9woUS5
 rjfYa5J6O7uioh9KeqlwCJQGwYaRlMbGbCjoa91ILG8CUqz5uxnbQa4iyn8tkuGgYrtf
 8mfQ3bcppShiCY76/Jvu28dgppCFueYmwcjM+Nf/FBcIPHcSVHlJhd+Sxzf3UofiAUOA
 fLzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCO3j13sbaZ5GqMy/FB8wCn/3DlpO00JU2keyMRjI43q7s2nsQCeAO5uiZxWVDKoC7Ag+rU6VB8VTp@nongnu.org
X-Gm-Message-State: AOJu0Yy8LoW1MSdWvXBNNlfglrCBixqt8w9LH3dDZ/0+1lTSBNUl+WU3
 kYl4/ad3ax0NMeU8RYynCMafUcbXkRsl2q3otrdL2H2UgU0hK5DGst5SQcKI5SufSGDd5Ec0EaP
 wNvO++mAjfvFzKkN18IxGQaStuueCyXBrCcbQf+Ppb+PH57bKgFgf+NDV
X-Gm-Gg: ASbGncvE+N0GGuyVTclzLJBdtc+3y3b1sJQ0FU+g2/w9kybVbi94hrylE7F+QNyN2jw
 Sz9qPgnaAQJvvtEULW8y7CcDOPKD5DRYZYIwST18eSdXOgheaTaTAQ9cPSCtz2xqIpj8OxGNFZh
 V8OjefIFgrg/EAarF+3y06QTOcFSa+0CCgtezBk537eyaz7fBcNWPFLxXUw//fofnsH8XedroM+
 o3T7x7qP9LeLsKP/0RBZLXm/qyT2yCN1dKRP3/diXTcnsyKk70+HY5lMW/Op/BqNbnRpoqoTnyg
 7Z1fxNFjS7TouSTWyZDHxyhKWVvFDRR7FhF4nxgBgsxzaD+Qz7+waLfEr+R2DJUXeBLOxQ7XTzQ
 T9KXYJzt29xo9c4ZhmrTaoXpw
X-Received: by 2002:a05:600c:1f10:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-475c3d98ac8mr90585e9.11.1761055782784; 
 Tue, 21 Oct 2025 07:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEomBwMqOaw32egMsw4rX1pGIa0IjlkYqKOOCjf+slFpc0auRuOoLVL037KU3CTQRBVrurx0g==
X-Received: by 2002:a05:600c:1f10:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-475c3d98ac8mr90095e9.11.1761055782141; 
 Tue, 21 Oct 2025 07:09:42 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471529598c9sm197196035e9.5.2025.10.21.07.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 07:09:41 -0700 (PDT)
Message-ID: <15c6f0dd-6e8d-4e36-9bc5-a7777fa1013f@redhat.com>
Date: Tue, 21 Oct 2025 16:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] tests/qtest: Add s390x PCI boot test to cdrom-test.c
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-8-jrossi@linux.ibm.com>
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
In-Reply-To: <20251020162023.3649165-8-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Add a rudimentary test for s390x IPL to verify that a guest may boot using
> virtio-blk-pci device.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   tests/qtest/cdrom-test.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
> index 56e2d283a9..a65854d2bc 100644
> --- a/tests/qtest/cdrom-test.c
> +++ b/tests/qtest/cdrom-test.c
> @@ -246,6 +246,13 @@ static void add_s390x_tests(void)
>                               "-drive if=none,id=d2,media=cdrom,file=",
>                               test_cdboot);
>       }
> +    if (qtest_has_device("virtio-blk-pci")) {
> +        qtest_add_data_func("cdrom/boot/pci-bus-with-bootindex",
> +                            "-device virtio-scsi -device virtio-serial "
> +                            "-device virtio-blk-pci,drive=d1,bootindex=1 "
> +                            "-drive if=none,id=d1,media=cdrom,file=",
> +                            test_cdboot);
> +    }
>   }
>   
>   int main(int argc, char **argv)

Reviewed-by: Thomas Huth <thuth@redhat.com>


