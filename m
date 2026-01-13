Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C16D2D0ED
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfe03-0004N7-Mr; Tue, 13 Jan 2026 07:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfe01-00049w-Gc
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:59:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfdzz-0000kx-Nf
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768309191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AW0dKP2Cap20Q6rB7cmMaQnFTDVTJS6nxmVvekQlsz0=;
 b=UJVG0EOp/8RR+KaTnUs+FkDUJP1pxWWWnj9tE/Gfqh6b1yMhrRX5z0ykFaWdUo0uLw3Qgs
 szJxE2LaiK8cdTZlxwKmCOus2o/ywERafE8UosIl9uEOc8ipXtN1Wy3WJYL6LvUt+c//00
 WCYXqbP0/gRWnwxKsUvS9RoTKWokJ24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-5XKEDrCRMxieLrdRFmL5PQ-1; Tue, 13 Jan 2026 07:59:49 -0500
X-MC-Unique: 5XKEDrCRMxieLrdRFmL5PQ-1
X-Mimecast-MFC-AGG-ID: 5XKEDrCRMxieLrdRFmL5PQ_1768309188
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47a97b785bdso54261125e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 04:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768309188; x=1768913988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AW0dKP2Cap20Q6rB7cmMaQnFTDVTJS6nxmVvekQlsz0=;
 b=uNK8Z54pj1JS2WLaEqB+jVj2Pj3cZAMFfaZkg64jo7hJluL2mWH/SsCKHf3/j+cAXt
 lcflwdNpRE0dygz9QCe1PF9E3G3TBU+B+j7IiDm9xKZxTgvi9oKp/CnANFfjEDzVr/0O
 hE0FZolnQc8vkQ08mtMCnpGZ/RaGAqdDkTM2kcHVy+J/3o+Q2jRDuSb2xJX/HPhQJIxG
 rg13fejCOO7Tvlv6lBGntD9+v0tCYqnx5XsGfJyZ4AraFQWs6wIlSqEdVGafMasKMJbj
 Eu+4CacxwovRPdyQ6Sq1bFJ9QMrQy6w/ivxeqrnV5iTJAQ0b+Kmw3smSrZGVcIiB1YNU
 CvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768309188; x=1768913988;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AW0dKP2Cap20Q6rB7cmMaQnFTDVTJS6nxmVvekQlsz0=;
 b=eoASbIzMlRYGq5/Iit3lYilF+7jWLLQ+9rStC5HXKs4d+fBBCwE49AzAbvLAL2SrMH
 atB/Vn1QFBjc+CgrGujaR2DxEXWuOqW03GcRJazBfbBhAhYHZYVcFynf2QQO09DuZsL7
 OUJSPLaTdPONiq/j134dw+TUt1c5Sg19f7rzBMWf7WnY5WDuoEUtKD9O6LxbNotsn/eY
 vFwjVRzRaA1bUY/kGUh02GeS9Q2p044OU1T/RJMVCjPg8p+ZsId5nl0DiReObDMFVuLk
 zZ5D8qm2jMgKo4nw44yAqMK6yGrLa362KtVtpixBTEnuDsLC2YOeGv/P+O4JiwfnezYe
 gV2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuYTUwG3Xqvna/DG2gmdh1Z2PSvbXk3wzFI1Jh+k6rKHb3Ceq6K1dGAitb9H1p4ivASQ6E2tA0aQb5@nongnu.org
X-Gm-Message-State: AOJu0YwjjibC4giscpwkCic+Q8KaTIM+FNANe7MLfJJEvg/AZ39K+E5/
 qhERCcNB8gSPwe2iXJCSo7OtyOmdY3MG/psH4+Fo6BmdNZOCnJzx5MOhP29yXL4KJbNyDjfgFg2
 sccDBL9BT8UToPlVi562AxlEYXN7edoRfq7EnYjaxko43SadZrJsMqza4
X-Gm-Gg: AY/fxX56nM5XCupd8ioL26l/cD3HTKSOR7gLmyzZnEn7V/suZ+zIDgGnaY1qsheIm9w
 sYDLYkt5U8zXQpsmO6lVuQn19z8HB/1ybBdtdZ6pSa0sEmZULuThgKf1TqwpBmmpsps1nV/2Fk5
 e9L0TSitY8eGWIOGzWcglEemOOencX/2ja7ansiTEvLzPXVmD3gkhiD5gsE1pQ60h0whOxkucLM
 8KvDnlgKhhDPse1JRxeRetOV8pfPG3oX3MGyznzVcml0wG6DoN73oN347glUf6+ERR7caScB1e/
 RPTUndmmxxVjl1bWjRXISHHzvcchYg0LeYqW8FDBLoTCl23WgTo3SGwul4RgKQKb5nCT9f8jFQ8
 N1d5w70A=
X-Received: by 2002:a05:600c:4fc6:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-47d84b3fa26mr213809855e9.34.1768309188246; 
 Tue, 13 Jan 2026 04:59:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcmb5yZmrgqo1ZQjb7jDJHYt2CmZD9dipnNcIWKRSHumAHC815DmA7wuNouKz2wukRaqxCkg==
X-Received: by 2002:a05:600c:4fc6:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-47d84b3fa26mr213809485e9.34.1768309187785; 
 Tue, 13 Jan 2026 04:59:47 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm400638995e9.0.2026.01.13.04.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 04:59:47 -0800 (PST)
Message-ID: <f2cd7471-2a70-4d83-9634-88b18dbcf038@redhat.com>
Date: Tue, 13 Jan 2026 13:59:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] tests: add QEMU_TEST_IO_SKIP for skipping I/O
 tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-13-berrange@redhat.com>
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
In-Reply-To: <20260112204026.710659-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 12/01/2026 21.40, Daniel P. Berrangé wrote:
> The nature of block I/O tests is such that there can be unexpected false
> positive failures in certain scenarios that have not been encountered
> before, and sometimes non-deterministic failures that are hard to
> reproduce.
> 
> Before enabling the I/O tests as gating jobs in CI, there needs to be a
> mechanism to dynamically mark tests as skipped, without having to commit
> code changes.
> 
> This introduces the QEMU_TEST_IO_SKIP environment variable that is set
> to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is that this
> variable can be set as a GitLab CI pipeline variable to temporarily
> disable a test while problems are being debugged.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/devel/testing/main.rst      |  7 +++++++
>   tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index 910ec11ab4..bb90ea5f15 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -285,6 +285,13 @@ that are specific to certain cache mode.
>   More options are supported by the ``./check`` script, run ``./check -h`` for
>   help.
>   
> +If a test program is known to be broken, it can be disabled by setting
> +the ``QEMU_TEST_IO_SKIP`` environment variable with a list of tests to
> +be skipped. The values are of the form FORMAT-OR-PROTOCOL:NAME, the
> +leading component can be omitted to skip the test for all formats and
> +protocols. For example ``export QEMU_TEST_IO_SKIP="luks:149 185 iov-padding``
> +will skip for LUKS only, and ``185`` and ``iov-padding`` for all.

"will skip 149 for LUKS" ?

Apart from that:
Reviewed-by: Thomas Huth <thuth@redhat.com>


