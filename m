Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB60CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNNc-0002Mx-K2; Sat, 30 Aug 2025 11:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1us0dw-000432-2a
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1us0dt-0003Nx-9h
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756479830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8kpJ3pGmoBotN2jHQuMwEk5LKEFiWkZwNSeVZoRb04I=;
 b=MD0gEjWGBAeqy2/CpxuhirajoWzf3HmCM8fVIMBYQbV7ZexUcSLBsfaFRwDe54hINwMHC5
 x+fIeW5HlU0twFzC+riIvhL7+i+Mvcjw7PzUJRvfSKUWV+6qJHYDGm0B1gZOLKlj4tQne1
 3Cutgryskh4YWTyuecSFkCIxyRxPRQk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-ZRY_Aw-OOJuKsFaQTOVIFg-1; Fri, 29 Aug 2025 11:03:48 -0400
X-MC-Unique: ZRY_Aw-OOJuKsFaQTOVIFg-1
X-Mimecast-MFC-AGG-ID: ZRY_Aw-OOJuKsFaQTOVIFg_1756479828
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7f7706f53aaso472679185a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756479828; x=1757084628;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8kpJ3pGmoBotN2jHQuMwEk5LKEFiWkZwNSeVZoRb04I=;
 b=JBhjvSMOejB1jCZ1EpeenvSHRT7Oqg3lXKUfSmJ/RNo8kZ1O5ERbxGws6Z3Eg8QW1b
 1/4ywNKxIL/pjQSk4n8mVaxtbOsfJ240pD3sbvbBYvA2uZYrNm3NHudRjcLPfavMzP7/
 UmlodQb6qqgDmn0XWqWPoXCbikdjbjPmCFRMxvdmKqIJ4UJehjMklihTCkrIo8KGEiOn
 HT87QCLnvJitVrOolyAgw+AgdOFtEp1ki9DqGS+9FvZW7xSkDwMPL78RpN801yoqHZSw
 ysktxp4cxd8rzi/l9LeWuiYGJhOi/shw0ZCit5g2dMrSvlpCXAkOCur2F/i14+fV7BgP
 zppA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdrOwGlc+D1U07bxm8g9mV3Y+BlAfpQVxWbxRKnqdljSI67NlY0ugCQGkf3qikLZUZCoM7EmENWgmO@nongnu.org
X-Gm-Message-State: AOJu0Yxx631qzLZSIs2AzB1aYDPXarDVz95CRPrUy7mdIwOkgvgBELIJ
 xysKafR8i3w54ySfMAdSJDmpdzB0b2YuZCvbzp9EwGkb/+OA5vvdX7az9HDkSn6kN8YBH6L7Wia
 8rL4bVYIwkDlvs8gJXG4boZf6Hm4s8etuUq7qphqvYytD3a1pxy1mrrmd
X-Gm-Gg: ASbGncvKhBtTft8tQNRlYpvTVYa3Efs4T7VwohdWhFFWwMPhViXNaKHtL/bhQGiKfc5
 1DPE7gIYNmruw8WSzDQmwLY/RbkV66M/C9sun/tUXRd0gYAc6PEc3OWOEK8bktyGT5AuFU0o+TV
 +bOgutQrKwWyfSPIiJhdslcZM5cW9r+SXG9cXXSIB9KR0Gs4KUbQZnmW2XyPc70s9LsF3ZBZaIi
 4+QeRr1Dq3CdOTexbM1pP+kB63epGcrpoGojTPt8Frp9XIMbw4xYOefo6fS8g/lKeNDHLwcuEdA
 II1sfK12JRss3s8Z2jMtakpafmLlSkDHXEPlSD3ZXp10j7DI4r/Ks9jgRLzlynxLTVi/
X-Received: by 2002:a05:620a:404c:b0:7e8:46ff:baac with SMTP id
 af79cd13be357-7ea10fc7a12mr3224100985a.1.1756479827826; 
 Fri, 29 Aug 2025 08:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNOkGoQImNqYevGH7fgcAv/Uv+PPpjQGjCFJaVatSHOG4ajwqpinFs5MVElOVm8L8LRknAvg==
X-Received: by 2002:a05:620a:404c:b0:7e8:46ff:baac with SMTP id
 af79cd13be357-7ea10fc7a12mr3224094185a.1.1756479827251; 
 Fri, 29 Aug 2025 08:03:47 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-48-43.web.vodafone.de. [109.42.48.43])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc16341017sm187465985a.63.2025.08.29.08.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 08:03:46 -0700 (PDT)
Message-ID: <676d7a3d-3d38-4c68-be44-50967f00ee95@redhat.com>
Date: Fri, 29 Aug 2025 17:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tests/functional: fix formatting of exception args
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250829142616.2633254-1-berrange@redhat.com>
 <20250829142616.2633254-3-berrange@redhat.com>
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
In-Reply-To: <20250829142616.2633254-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 29/08/2025 16.26, Daniel P. Berrangé wrote:
> The catch-all exception handler forgot the placeholder for
> the exception details.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index b5a6136d36..5c74adf224 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -173,7 +173,7 @@ def fetch(self):
>                   continue
>               except Exception as e:
>                   tmp_cache_file.unlink()
> -                raise AssetError(self, "Unable to download: " % e)
> +                raise AssetError(self, "Unable to download: %s" % e)
>   
>           if not os.path.exists(tmp_cache_file):
>               raise AssetError(self, "Download retries exceeded", transient=True)

Reviewed-by: Thomas Huth <thuth@redhat.com>


