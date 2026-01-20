Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066DED2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi7bk-0004af-B9; Tue, 20 Jan 2026 04:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi7bg-0004X8-5m
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vi7bd-0000cJ-NU
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768899656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/mlcXCBZjFGoCgSsaFC2nBFixl0sD/iWjmxGIsleSEA=;
 b=fRDmbckv5nA67tD21RoV03HH93xXkjCTVkbeA/voSy+79Fd3FfIa8OX/vMGl2FuAG2lMQJ
 h51VzLTJvWWBDOzjgQWKcJVIWLhVmN0B9omCkMDMOBqwR1loFkgwPwGaSGgjbmT2WwPLxc
 cv8sybthuKbVQFbYaS6kQAe0hAtU4bo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-AVUHLa31PN2RCsglophXgA-1; Tue, 20 Jan 2026 04:00:55 -0500
X-MC-Unique: AVUHLa31PN2RCsglophXgA-1
X-Mimecast-MFC-AGG-ID: AVUHLa31PN2RCsglophXgA_1768899654
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fdaba167so3464689f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 01:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768899654; x=1769504454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/mlcXCBZjFGoCgSsaFC2nBFixl0sD/iWjmxGIsleSEA=;
 b=sVy0shp3BIegaO2G0p3ftZb9VruK/A9KkzoW+mTr4trPJ9DAipzoWquhb1CSD1pXXR
 E6I4Gw0tewqgcVAgO1xkdTtrCT4qdDvsVlLpwrPILHW3jOf2U7t0IwM0t0aE77ekvU4m
 aJOtjavlEOrZHcl4mN8b80ThvWYZnTWqsmctLHBruGdaRrwUuf6IsRnC939XkK61zpLN
 GfNzftrdisVBCQ0bBiz8z5q/OnElCbrnCPcp/6RRQFKG4LIQx++Vs5liP/t3sn5lFSvI
 /xFMrjjA7lY5q8lDQEg1/kLC6HtegHjBmrVOMWmp88gd5+pA24AnzlKtuYsL1T1LCm2g
 /pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768899654; x=1769504454;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mlcXCBZjFGoCgSsaFC2nBFixl0sD/iWjmxGIsleSEA=;
 b=mygiATY+JMo/XjS8a+YsymMOGy+02fqBZV8vu4pO8idjRqBc7NOYBlUARKj8IebvRN
 9+ApZ7Rz+RHzbXiL+49JVvmyX3uc38OhmzCcs00aIaMRMqu+hKKLXqS+d+WE/y7ri0Qa
 VL7t3blGcKecnhaHK26QExRLW1zH46qm/H9t9MzT8Gre4p8RcTYrFecE+SDAKh4nHi9m
 BFYwOvMuhTIGuJy0lNNex/XhtrtI2fElI4DlKPu26rCTrFjUAD5G/5y8H+eodI1YtDrX
 AcIdCmu3+JTzypKXlY+zmHafkBTP7zdoTe9SbbVyTvGDun45WNpoRJeYkROk7vr1K175
 i5Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvBZ6VD7uVIEpnPqfka4uxufilF059YXdDVR9N4/rw/KFAcNVfLp0ntE4zfEUPFBWua9IozCRiX9xX@nongnu.org
X-Gm-Message-State: AOJu0YyYTSv8dBD17u0iuC+kTKTsNfZb33lBpXSoYKjw5glSSJZS9csd
 /ZUGDUiNkdyrFkTnvHNEPWKIArKhIFR69RaOzLyw3dGG0eFMh2rwOHjGiUHDq+6A7edUmcYEBAu
 om36fteZLFpIlwDgLut1AIBbb0tqkOl1NZhmcaBfCzm2CnFAbWDN9juH0
X-Gm-Gg: AZuq6aKvpbUOOGGxJVsDuFmA7s7LPR7Jbz8vmB/T9bFfNS+ozj9zJW5Ggh0uADJ8DPJ
 d0lDykZN6yu6TnLbEx4JfrmnqnkceMI1tJPsLtZoj2m6SDFjQR6pbMrzrMrPbCAPofY8L4ZE4KN
 4RgePm48ex5B06KOLX2Ruj52j+rQ7a2SbAYg6fv7WoMjRTCswe6FrTFCetIoBoEbpu+xmrfEvBk
 2qzyht8BJQalfzreV1E7Ve/UpitLKvEalPrc5BGrk9rvNSXssVNXH1+IhVpqQD7PX/CZxhuDYjq
 LvbkHHFPHCvZw14ipGJkJmuYyS+F+JvjbgujA36si9VmUJUTV1NoT6fwWQfDdTHkoxxpg7AOCbs
 sBkT9vtJ2TAR3b8YQOiV+gPvgCWDTjZ23Rk4=
X-Received: by 2002:a5d:5887:0:b0:430:fdc8:8be3 with SMTP id
 ffacd0b85a97d-43569bc1912mr20195310f8f.29.1768899654253; 
 Tue, 20 Jan 2026 01:00:54 -0800 (PST)
X-Received: by 2002:a5d:5887:0:b0:430:fdc8:8be3 with SMTP id
 ffacd0b85a97d-43569bc1912mr20195249f8f.29.1768899653760; 
 Tue, 20 Jan 2026 01:00:53 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4359314bbc6sm1259439f8f.12.2026.01.20.01.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 01:00:53 -0800 (PST)
Message-ID: <51794ff6-3bbf-4c39-8a8d-4511c9e13bfd@redhat.com>
Date: Tue, 20 Jan 2026 10:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/17] configure: unconditionally install "tooling"
 group
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Ed Maste <emaste@freebsd.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-13-jsnow@redhat.com>
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
In-Reply-To: <20260119212744.1275455-13-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On 19/01/2026 22.27, John Snow wrote:
> Alongside meson, always ensure our in-tree tooling group and its
> out-of-tree dependency, qemu.qmp, is always installed.
> 
> As a result, several "check-venv" invocations can be removed from
> various testing scripts.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Thomas Huth <thuth@redhat.com>


