Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC7BC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 16:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubM1Y-0003gI-JB; Mon, 14 Jul 2025 12:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubL5c-00055j-8o
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ubL5Z-0003gl-PG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752506850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GeYLliWP7ybWJrdfQnoPje85XPqiaMjbahR9uEAi7C4=;
 b=hMUJHs6HNLvSlYpXhAjtAzaIgKwQZIg98nuD8mmTfZFyVrKrwGzJGTig2qXWbdA9X5XqoP
 NW7FDE6+3cPfCJP+G0OVzAaEHT+ZoSfN47jjArsxnSVxLouxM5+TgcH3quBZEkQHbbvmIg
 2ttbJKR7SKvz/e9cvsahX+t46u8gJiI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-g2hU7W1AMMyCJM9Lciui8w-1; Mon, 14 Jul 2025 11:27:29 -0400
X-MC-Unique: g2hU7W1AMMyCJM9Lciui8w-1
X-Mimecast-MFC-AGG-ID: g2hU7W1AMMyCJM9Lciui8w_1752506847
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-455e918d690so14115735e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752506847; x=1753111647;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GeYLliWP7ybWJrdfQnoPje85XPqiaMjbahR9uEAi7C4=;
 b=pAon6gqrNUfSvSIYvks1eLuMxoGijIUZ0BvFlRUbtjhbsN2OgliPWHrAg45c/XeWpg
 VimQZdRUJu+TApjO7E4VbFSUNZidlApQfmpc/dMOT6ifsqfNhmf+iNHncsdXruYJMPxB
 xacibiB8zyH9J5XwX1LJ1lqlpn4oXJhiThF8mD4WHAXY0WCMMiGXPM5c+jboi/t/q9PK
 OS7Bc45B0TNJsioDm0DOVkkiLqwrmumvHw4t4Rp4XcireucdKPWeXcUSeyCyfAP4Hvlg
 E6SQumgFTm5KD5Nh8fcpXS2Tkl3tlMkZsxgDy0BP9CHTH6uUEZ27rLATAzISSRDBdYL5
 Yr2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJUQs8ptVMuHyPrVPOgtRFL1I1jR2tkq1UuT4/VTBdipghubsbcBU+SbJ8RtVuuxNviAmcvFksTNHP@nongnu.org
X-Gm-Message-State: AOJu0YweewsiOdgSfBd9XUWTnEy/75dpHntsgljpxOLBa2TmWmyKyVzN
 GywSP034vq3WeVDCYI+paVha43rOi0yKKq+3cbPnlf5cm49E69INTJSZLaHJUhJ+BIcj3+UpLtg
 bGpshayyC5C9ir+n8FFXxDM/S1TKdEUILFdvhVI3EX6CuLnIVtTpKzFB+
X-Gm-Gg: ASbGncvGz3kT5lKEs/tOXsRZ6pqijpYFMNnCc+QeNrFeYAQD5SQK8gJTdcPVdE4zYpK
 Z3IHQtk4KQYEzjA5VLnrJiC409BavPwXHTovS/fL4km44tSDVkV8/NmrmAPTvUh0PGFmB7nVWJ5
 ZaSEkW47cIIhUm9HUX3sEnCxmr9hjbjTI7V/PIrz9DtslcEu7Zj0WDexwFCUjMoZFfpuwuR9tNd
 uuPVTUhimzaY86v/2/2qEMQiH+3Qre0D+XWKWfKXUuDdo9c7mLFStOOMRpMIp7b3jV3WdZjj/qt
 srbcX6VY4MdUENKR/P3W5voKeu+fPGQTwA5AVS7KWBXEqXtnhqlMo7ly+HgAfTw3s5gTDWGbxgB
 5oAKq
X-Received: by 2002:a05:600c:858d:b0:455:f7b8:235c with SMTP id
 5b1f17b1804b1-455f7b82478mr88756075e9.14.1752506846707; 
 Mon, 14 Jul 2025 08:27:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK/cYcIaAcGtgZNN82SKKVfVfqmc7SA43b4jLPI3pZXW3FsEAXoyXKssML9LqCnNkAZsTFlg==
X-Received: by 2002:a05:600c:858d:b0:455:f7b8:235c with SMTP id
 5b1f17b1804b1-455f7b82478mr88755855e9.14.1752506846153; 
 Mon, 14 Jul 2025 08:27:26 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-106.pools.arcor-ip.net.
 [47.64.114.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd241210sm137134485e9.0.2025.07.14.08.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 08:27:25 -0700 (PDT)
Message-ID: <63cffd3c-500b-4bbf-8ecb-18799fb0fd6b@redhat.com>
Date: Mon, 14 Jul 2025 17:27:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host-utils: Drop workaround for buggy Apple Clang
 __builtin_subcll()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250714145033.1908788-1-peter.maydell@linaro.org>
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
In-Reply-To: <20250714145033.1908788-1-peter.maydell@linaro.org>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 14/07/2025 16.50, Peter Maydell wrote:
> In commit b0438861efe ("host-utils: Avoid using __builtin_subcll on
> buggy versions of Apple Clang") we added a workaround for a bug in
> Apple Clang 14 where its __builtin_subcll() implementation was wrong.
> This bug was only present in Apple Clang 14, not in upstream clang,
> and is not present in Apple Clang versions 15 and newer.
> 
> Since commit 4e035201 we have required at least Apple Clang 15, so we
> no longer build with the buggy versions.  We can therefore drop the
> workaround. This is effectively a revert of b0438861efe.
> 
> This should not be backported to stable branches, which may still
> need to support Apple Clang 14.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3030
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu/compiler.h   | 13 -------------
>   include/qemu/host-utils.h |  2 +-
>   2 files changed, 1 insertion(+), 14 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


