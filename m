Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5BDC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 06:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsFu4-0000JB-KC; Wed, 12 Mar 2025 02:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsFty-0000I0-1a
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsFtv-0000Xk-5i
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741762149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iftUVt49VrEyx0/JxVEDpN0ZcISAZ9GCLkbVbUiy6G4=;
 b=NL8wvlmQ13btxIuk1kHdpuKf8WPi9FG/ydTJYl9a3sKsnre/GSn0PH/Ydu/eh6ExQ5BbK0
 Rv8PughqTioTmL1AqRlsq4N1H+sMzCvsMjLvNMeUcl6wA7jki6x+E/ndY6ga2mVIxeRXQ3
 1J917nGYHIFTus+3KWH5O4aKAVt4oLo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-zLeqnMquM5CrSnMFuqeO2w-1; Wed, 12 Mar 2025 02:49:05 -0400
X-MC-Unique: zLeqnMquM5CrSnMFuqeO2w-1
X-Mimecast-MFC-AGG-ID: zLeqnMquM5CrSnMFuqeO2w_1741762144
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso14580925e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 23:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741762144; x=1742366944;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iftUVt49VrEyx0/JxVEDpN0ZcISAZ9GCLkbVbUiy6G4=;
 b=RYnKFNRL7R/BoNI4BnOSH8EoX8rp6tTXP+ymOp03z2n2XCNMcpy0SIL8hUXDoD+jZ9
 qksqKMts8ZVOOyTCqgPzkGN416eqva0A5t7RPSXj4R90oGWcQ1TjFXuYOedYV9tUV5W/
 ffMNNxQa9dlHicCZQ3bxH9a5NVFwidnEqHy6y13e7IFoxXJegXndkEP8kb8FXHkdPK2u
 m9vjkN659t6V7RnUYxXsP0P3qXS//cN0qIvfbjxnBmrPl2KLjMRLn+56j74/Zfz3bWL3
 +lCtST6F9eWzWTEKSELPVIxXWmReJPk380XBK59oyqaPPPyXVSO2mxT+Wctam+MT96cr
 IPoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfbyrM/jX3CJN81coawce7J6myniOdtatH2a6mR/D3/HSJQk7h99K37U/Ism/kCHrjQ1D7n2EgRc48@nongnu.org
X-Gm-Message-State: AOJu0YyVdIfGz4pxDRiiTFiAbOltnOIJsUCx3/Q0B/2Yk5L8d+7vV/M4
 3SQFmL2S3aOivDe6GrcUSz60aegNw6vzL90g5yq6faPdJ0yQOFsYTl6n04sc1ZHZaMN8MbkfD7g
 KxBMn04gBrEpEIeLv6BfvosDAn4O3cXwIICHWteWF3ttvlHCbD4qZ
X-Gm-Gg: ASbGncsj5c3LPhowMi3IolDNo+hP/KhWEQ/ybqh4MR4M12FptN2SiZov54adivjcJrh
 ZfViVOwWQzhPew2L04x//WaWcbKk1ng+GOkLVeIL/LOwVFHRONknA3NPvTOdEVWW5HvQBU91qmu
 3gVeCoxldYRFeHj9fBOwklobWXTfpw9FL34N13ozy420kauMW8kc7Mj8WNhICulim5VMUhiDo3P
 r5IJL+rf8utvPrAxRAVTs4kVb3Y2SxxWaGXZGCc0/pLizQX4dq0QBr0XPvS/TSwS6u2N+D/wVce
 tmAUTK8WaKhkaGgnjNBTaOdlIorykk0oirrVQbbHQuzzTtM=
X-Received: by 2002:a05:600c:46c9:b0:43d:4e9:27f3 with SMTP id
 5b1f17b1804b1-43d04e929a7mr41155825e9.9.1741762143979; 
 Tue, 11 Mar 2025 23:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF50eKR/JbBeQ2hCJDN6+fAc4p+XpZ/xeP0qGAPV6I52D23iHCoEt0fBUzsNDipGzgEqDqNnQ==
X-Received: by 2002:a05:600c:46c9:b0:43d:4e9:27f3 with SMTP id
 5b1f17b1804b1-43d04e929a7mr41155725e9.9.1741762143571; 
 Tue, 11 Mar 2025 23:49:03 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-149.web.vodafone.de.
 [109.42.51.149]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a757a41sm11550175e9.20.2025.03.11.23.49.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 23:49:03 -0700 (PDT)
Message-ID: <59af86ef-c23e-4bda-9dee-8484ee8c16a4@redhat.com>
Date: Wed, 12 Mar 2025 07:49:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/functional/asset: Verify downloaded size
To: Nicholas Piggin <npiggin@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250312051739.938441-1-npiggin@gmail.com>
 <20250312051739.938441-3-npiggin@gmail.com>
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
In-Reply-To: <20250312051739.938441-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 12/03/2025 06.17, Nicholas Piggin wrote:
> If the server provides a Content-Length header, use that to verify the
> size of the downloaded file. This catches cases where the connection
> terminates early, and gives the opportunity to retry. Without this, the
> checksum will likely mismatch and fail without retry.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/functional/qemu_test/asset.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index 6a1c92ffbef..d34e8f5e2ad 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -124,6 +124,22 @@ def fetch(self):
>                   with tmp_cache_file.open("xb") as dst:
>                       with urllib.request.urlopen(self.url) as resp:
>                           copyfileobj(resp, dst)
> +                        length_hdr = resp.getheader("Content-Length")
> +
> +                # Verify downloaded file size against length metadata, if
> +                # available. dst must be out of scope before testing st_size
> +                # because # copyfileobj returns before all buffers are

remove the "#" after "because" ?

> +                # flushed to filesystem.

As far as I understood Python, that's the main reason for using "with" in 
cases like this here, so I'd maybe even rather scratch the last sentence
completely.

> +                if length_hdr:
> +                    length = int(length_hdr)
> +                    if tmp_cache_file.stat().st_size != length:
> +                        print("st_size %ld", tmp_cache_file.stat().st_size)

Debug left-over?

> +                        self.log.error("Unable to download %s: "
> +                                       "connection closed before "
> +                                       "transfer complete",
> +                                       self.url)

Maybe it would be good to include st_size and length in the log message instead?

> +                        tmp_cache_file.unlink()
> +                        continue
>                   break
>               except FileExistsError:
>                   self.log.debug("%s already exists, "

  Thomas


