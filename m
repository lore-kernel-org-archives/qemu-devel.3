Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3592C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvrcf-0005Ch-4M; Mon, 17 Aug 2026 03:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wvrcd-0005CW-1P
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 03:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wvrcb-0005nf-Ck
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 03:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786951138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M/QXPsbIktIBVl+vQKCOQtcV0tFDtGVhtoMy0xYsuSY=;
 b=Zz/eDHNJiAsib6rpYlp9wt5Xw5KmkJeMkOXlrdtchOvKsHO//o0J9CpCb9KYESgOq/AmCK
 7Cvlqrj7XRTCyF09w6IN2PHAZmV8Cemy1u9upV13T86KrzdxgT2/pJW+k1sgdzvYSjMh5P
 GIuJfoatUbKqqt3sv6WMLox+xCZYpU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-PXD3dBrHN4K53qV0AG0Y5A-1; Mon, 17 Aug 2026 03:18:56 -0400
X-MC-Unique: PXD3dBrHN4K53qV0AG0Y5A-1
X-Mimecast-MFC-AGG-ID: PXD3dBrHN4K53qV0AG0Y5A_1786951135
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-499900c9d99so12770485e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 00:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786951135; x=1787555935; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M/QXPsbIktIBVl+vQKCOQtcV0tFDtGVhtoMy0xYsuSY=;
 b=coY7Z2X/+NhQuVLh6MUAMyVfbL9BF6hm97zgPbE54zZVtOWuX8E+1pvgq0ckdYlTET
 4u8JIFQ/ZDeQPzfMjoRABwtqLA62H/gTasPcouozw0WCGR1d+TYmw1yo8HDwQnbzuwE2
 kNF6ny2iJlf7fdXS+cVSEh4m6ZJ5bbKfn4hRTdFQb5QT8bfN5pgWNVu99G9iXZ60TFEN
 3EmzqSdIaAhsLKyQWOOJWApKsSt7fq33WAhsOW2eQ1cuxCKlbPp3/3uyrzMF1U7+qPbH
 Ear2YAr4/AyTfF86lRJDJEHTaT4eLPgQq0l4I1vR9ONONqnqH+dNNdqWavdZKSsgtQvw
 yZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786951135; x=1787555935;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M/QXPsbIktIBVl+vQKCOQtcV0tFDtGVhtoMy0xYsuSY=;
 b=s9Pk9MgEMUo2S1J5hik9Y933OmOykOAK2FI9uAmUY/xcqS4PKr8jWLhso27sFLXY+l
 Nof1lzlaQ2ZmI/5lxk+KYKm4JYSfiVw7JxCLAiVh+/S35UWMfZryR0/qXX8JTQHlyrhv
 jmS4JnnAq/PRz+UsdtblqzRm3UH2bBSfTzct5XfyhV4J3GSqj5XkUck+BD4Uero/mOxo
 oIF5LQsh8qBjJT1ix+hnIV/iYxaADcdwFNblKU/JMpRW6/0NMLnXBumsdn8Pq6dAXjRE
 ZbM3+cZTr93peRZLXXcFOxYFgw9oM9rgGPHNo4nKHdPmC3Hd6m1HBA8otky6MV6Kx4c5
 Zu5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGBwiTQBt2vpbCgyagoYs3Q0+CWthiF25c5cor6VlIPJWWx8qK67MeznBeZkyJkWJdu4ssCjCr9YGv@nongnu.org
X-Gm-Message-State: AOJu0YxJB4ac6Q/crw/fLu99uk6avv9puIMoQdEdZbrFQNk8DDobyLRJ
 C+MWYRdmj//HXdVSRBYRorXNJioxdtAjdantFnqpMXoBxj5v88VspZRC1/w+15IOFKPIFmr83d3
 ijIJlP2E1S0aCSiKU7V++jVjJ4w+y2gmpE8GlllxdJkH45vkebxoUB9k4
X-Gm-Gg: AR+sD13/cbFeF8KFParXR20myzFLyQdwSJPq5HsDJ8trxn7rIQtMe0NpxZdLjor4kf8
 P0MvI5bkD5+Wgc1UiUxQeU94CXCsIy/fQ0zkm3n6LIjbogFAANutwXlHB27hgP/wFf5s1QbAPIw
 oILjO5gvmNpyHfkvfwU+dF16gmZNRSoYSsBkmGgBUdABlHU4e3aoyxc0NIRsq0IyJ9moN+EaKb9
 opw47JBeRgc5B9RBjJQQ7rbwwY3AKgkj4bKDcsN2cpWPjyTsfA37svMYjqaq0RQSNsbyQSIJDwo
 hwjANJkF5J8/DcNXasLWvKccpLtp4d7mIkTJ9Pi2TG7V1uVAl73f9hcYOlhbHYw2m1uvIbeW
X-Received: by 2002:a05:600c:3796:b0:495:4811:7998 with SMTP id
 5b1f17b1804b1-49987993e08mr292034825e9.17.1786951135003; 
 Mon, 17 Aug 2026 00:18:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3796:b0:495:4811:7998 with SMTP id
 5b1f17b1804b1-49987993e08mr292034435e9.17.1786951134634; 
 Mon, 17 Aug 2026 00:18:54 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.27]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999619a7c3sm114070035e9.15.2026.08.17.00.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 00:18:53 -0700 (PDT)
Message-ID: <54495516-9f01-4077-860a-a4c9cc612a73@redhat.com>
Date: Mon, 17 Aug 2026 09:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: fix pylint false positives for cv2
 module
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260815072421.4117291-1-marcandre.lureau@redhat.com>
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
In-Reply-To: <20260815072421.4117291-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 15/08/2026 09.24, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Add generated-members=cv2.* to pylintrc so pylint skips member
> checking on the cv2 C extension module, whose members are not
> visible to static analysis.
>
> Silence:
> 2026-08-15 10:42:08,710 - INFO: qemu-test.test_pylint Checking files in /home/elmarco/src/qemu.qom-qapi/tests/functional/arm with pylint
> 2026-08-15 10:42:10,941 - ERROR: qemu-test.test_pylint "/home/elmarco/src/qemu.qom-qapi/tests/functional/arm/test_integratorcp.py:83: E1101: Module 'cv2' has no 'imread' member (no-member)"

Alex recently already sent a patch for that error here:

  https://gitlab.com/qemu-project/qemu/-/commit/dd14a21b9dc1

Didn't that help to silence the message in your case, too?

  Thomas



> Note: I also tried with extension-pkg-allow-list, but that didn't work
> for some reason.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/functional/pylintrc | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
> index 949bea611fe4..373aabd6ca3f 100644
> --- a/tests/functional/pylintrc
> +++ b/tests/functional/pylintrc
> @@ -79,6 +79,12 @@ disable=bad-inline-option,
>           useless-suppression,
>   
>   
> +[TYPECHECK]
> +
> +# cv2 is a C extension module whose members are not visible to pylint
> +generated-members=cv2.*
> +
> +
>   [SIMILARITIES]
>   
>   # Minimum lines number of a similarity.


