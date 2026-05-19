Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32219CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 03:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBby-0006IP-88; Mon, 18 May 2026 23:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPBbs-0006HZ-JP
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPBbp-0007mp-7k
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779163147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SZXk9n0GICLWrqnc79UERiMshy9yOKaaTKzI2r1bV1Y=;
 b=BfPIGlHcSbFl/BA9QDWgIjzXpjc7VrTakCY1kbEYlRdtz7aKUJH23SwKkDLYo5ORO/AoXe
 d0+Q6C0NhjgW/MG2SQrOqTkwca9SWJeD3CI8ZMzeFkKuunCjJFkUXeZ4FPF7nTsqtfLgDG
 perR/hRXpmOp/qZj148b4LUqU2PIQW0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-NjYoybYlO8GE7WYorm0dAw-1; Mon, 18 May 2026 23:59:06 -0400
X-MC-Unique: NjYoybYlO8GE7WYorm0dAw-1
X-Mimecast-MFC-AGG-ID: NjYoybYlO8GE7WYorm0dAw_1779163145
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fdad6cce4so11239535e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 20:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779163145; x=1779767945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SZXk9n0GICLWrqnc79UERiMshy9yOKaaTKzI2r1bV1Y=;
 b=DlwX98Wh9YBJKfjp3H75PfJPT3aMW+FGDh0w+nW3YDw0NSjaFLGq9+BSo1p+o7veDw
 XlTdWAllb4561jy1KmhKsbrJN9nFtK/T9me/r4jZz0NsgBdCKa4Mc5wdvMxBFGnHFsDG
 MIHTvwZ5Ag293iFqvxgV83G60lZ5lx72KPbmk4+V+Fb9dwFpyJKbIUIuCjc04yxQmbRb
 u7Xa4EhrvbHwWA1kLqDkmEIPPPsq61dxB2jm57GkaStFmk7X440XOamIzCu9XRxIYrVQ
 tjGWeoUY1tupKK1f7vQs31LOcQCgzT/tijh9T0Aw9YfvzHTTnhdoGNkjSc++bwE8468c
 3tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163145; x=1779767945;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZXk9n0GICLWrqnc79UERiMshy9yOKaaTKzI2r1bV1Y=;
 b=c6xYz1GATSzu93Q+pa3qMO2yYKeRtOIRxOgizAau4qhi7OyrRztdr0Q9zpQ+AWj884
 gtnIZa/S9/xA6evaphR8xT72duaz9OOVnd4+Z7704N3gL0puh7OL7XAFV/ndsEsMI+ig
 qRElXFl3QPc3E+quj611S8qQUb4d4MCwGRRzdCNdmFnN0+TV1zUCGp0fEjVcJ7lYbmx+
 r7M8367BrVuH9D9rBYT8u7eVVcBXih+1i2YuRbJ+aCWca2pYab6BvxzwOli/7liRGp2g
 +GFXdiYun49uUQD2SpAqy4QKwiWr/RKH6GreiPCtxiZMJvwaHXp+qeFdpvOyYY+z3YdT
 5JLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wC5/S3nEWSa4Cy/20+6PkFELC4SVYvSZ1aXosnX1mEojfJSDCThBnkDBv0f7y36bAYtqCDUWggENl@nongnu.org
X-Gm-Message-State: AOJu0YxRWYAdpBoNiJYCzfEiUl2H10L157aE27CmdJRtQZFsrJFJuVLt
 SwEGG7aqThIAnAEN9/zdALzMHMrxrIcxbx+ZXi/Ys7rDmewv58BzFuz2T9bMMRSWuUWD4ZgVVPp
 8tP5lkVp9LS/L1rms9gCkXfI+YDYzQTbwhOFK7FZ0T2IESnCE+Hy8fXka
X-Gm-Gg: Acq92OG7jW9SUEYlPiGqQOQQal9qBM0Ya/LefcecIjO+m35XPpv2lIuMtG3M9wnNU5b
 XYYBPVM+ExxkBtDhsgEexPo8XfuH7sxz2WZ6XyQqM0Y/VYkZpDB7B9BsY9zDQrhBHkKS431jHfC
 39kOFDGY8XkfH1F8BzqXLr5gtlh1uqdoLtRYDNBfi5qW0lZiSW6QZsuxOWLefAzI0dueyXE/NJa
 wFNqvv4YzUNPUTXYitV8UKbp2biUx3njaTt9IXEzsdL7D6r5+9AeEUL2UjEuh7eY2+Z4XJbWbh4
 fY5j7NxgcnEMZIHhCUPLsWOwWrGasrYFsUQtJd3f4jUia1xHLh0i+HRYAb0G8OXPJuJYvDNncUZ
 cr5hSxUmYGCB7XUPVJpU=
X-Received: by 2002:a05:600c:c4a7:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48fe539519dmr262103595e9.14.1779163144948; 
 Mon, 18 May 2026 20:59:04 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a7:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48fe539519dmr262103495e9.14.1779163144657; 
 Mon, 18 May 2026 20:59:04 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.131])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm298009215e9.2.2026.05.18.20.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 20:59:04 -0700 (PDT)
Message-ID: <a829f2b5-d50a-4bef-bbe3-27995a9505fc@redhat.com>
Date: Tue, 19 May 2026 05:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/exit-with-parent.c: Close the file descriptor
 before exit
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, lvivier@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20260518184333.8505-1-rjones@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <20260518184333.8505-1-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/05/2026 20.43, Richard W.M. Jones wrote:
> On macOS we leak the open file descriptor in the background thread.
> Close it before returning.
> 
> Link: https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04286.html
> Reported-by: Thomas Huth
> Fixes: commit 886898baad ("Implement -run-with exit-with-parent=on")
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>   system/exit-with-parent.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/system/exit-with-parent.c b/system/exit-with-parent.c
> index df65d2231a..d236944572 100644
> --- a/system/exit-with-parent.c
> +++ b/system/exit-with-parent.c
> @@ -109,6 +109,7 @@ exit_with_parent_loop(void *vp)
>           /* Behave like Linux and FreeBSD above, as if SIGTERM was sent */
>           qemu_system_killed(SIGTERM, ppid);
>       }
> +    close(fd);
>   
>       return NULL;
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>


