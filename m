Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDACED111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 15:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOdvy-0005Sw-15; Thu, 27 Nov 2025 10:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOdvs-0005Ps-UP
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 10:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOdvp-0008Ti-80
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 10:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764257351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OUZ6TUiBHRVHWPmxhhsUMoQx9jy50CaRUke64btcajw=;
 b=Hgja4DC7EOiub38+gQ6f0y1/7NUty85KNroksr8UHT700Zhig/Pno1t6tGD29V5n5m97eq
 NPoljF9Nq13Uo8z3agiOKdvPciYfpaAYzkvr3U4JrTve1u4FpG7F7SWiA4C5oh46iRYFEd
 fY/6cLHPJiMk4XA2+CfHSsgY1U9snDU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-QVMxtLO-NWCOivkFojwhow-1; Thu, 27 Nov 2025 10:29:10 -0500
X-MC-Unique: QVMxtLO-NWCOivkFojwhow-1
X-Mimecast-MFC-AGG-ID: QVMxtLO-NWCOivkFojwhow_1764257349
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so6077655e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764257349; x=1764862149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OUZ6TUiBHRVHWPmxhhsUMoQx9jy50CaRUke64btcajw=;
 b=V4rv8G0A7aVgh5a7f1G5oSawUudZWXBqBT1LDDYLcvQJ3s/I8Qbc074VqGQBpLCoVT
 6Yigl/3cs6+fUIsljpks97M+/heGOU0Xx5yYcnF1/nPpUcCAJdDnuXsnJ8AnmoEUlg3C
 GX86c8ET2mQMFNIRNDonU5Cic05+o4nhZkLUJqgkrIckBsPlt70K2TY/7orVgl+J4SBC
 9yK/5tBDNgnkIOB5FvARcBrX2Ys/h+ns7Ub0/svjjmCXweo/43ZxpFE4kLMoVOGNosZ3
 H4gtBtKoUTz0J3QIelIcy1c7CNOQ5GHMpTtqn+e/hfmfc6fip+YkOnu4LaKOzVQz+sq8
 oWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764257349; x=1764862149;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUZ6TUiBHRVHWPmxhhsUMoQx9jy50CaRUke64btcajw=;
 b=Ta8ag5y1cayvbzgjtUpnPyl6hZl9t21GhbEJ7CKGd32Cft6nmJdL6hsqTvN8+NvpiD
 hSocGg/6HJl0M2LJwSRO0lYJzHRs2av+I+eQwmCQx4L2eE0ngYuvZ4C3wtqmOCAb6y9y
 5D+tZBfqbj3BSXJoTudXhkg1wROGvFnRc7CkwhEp8P5p3+SKMNRYqmiysde6XtueABQF
 2brJhmiohh9S0XibDUSJZvYz0kYMISKDk7Ud5JlLZ2bLkyqu0NMg8Qm0qEdiNv5BZew3
 6TE7YuqU3obzRS6zuIwh6p2ri+Q3EXgJaeDNAkJNB3Gv6Hb6IKoywkdb+cRVYsnyrlsc
 ks5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTrKO3lccq2NfE3mQFbekN6PeHlg5kGJNvSDvU4dz3sTgGtriT487kyNqZXjGdRiRE/dRliAKP/A8r@nongnu.org
X-Gm-Message-State: AOJu0Yw83Vy1oaTxKAA9t/9xlJpgajyB7O4VKtItvs7FTH2/By48nhtl
 175q4Dux7eC5gcNcPf66PYpN1MtAOyjIWmPi8JSZVjpDNGq1z1BJvfeIXudtw6AZlT/9MMct47N
 rxnW5AoBxU7PVz2ygc9p+oCYwJpmjuRV6fjDwOF+Xibi24QySrmx6OC4Z
X-Gm-Gg: ASbGnctKBeXdWF+YgIHt9FN6PvpRxShYCR4eNyt29a20FzsQupVZDL05cH+wu25qbGz
 S3GupquAF+vSM1IzfhyyN0W5s8waSIu1gAKzoh4if3jYZDQlQRj3LkBC76LJOvJz4LkQajHyBlA
 KNvN8Td/CVQhqKzueL0LNTZf9GP0FBKNgem+U9+9N4SSnZ60+Pdz7+yfjZ96Rlv6wVzgpzJv/vp
 NTW0+wucXqkh1et9j7m/Q/b5OGj/8Lq1HA3+tElx9dFY3t2vKIMFeCY9mvQvEz9Mqbg8/oiDCLN
 t7qIGVJ5QcY1dqBJs++Cyn/Xy71T5kL87cQ6o9JLRINWhQtcOd7uWxhNs+RNC3JvdUsccMzaFPT
 BnNIKNTx73OU7AvRDNYPNhwINgF2A9gXVHGo=
X-Received: by 2002:a05:600c:45cc:b0:475:daba:d03c with SMTP id
 5b1f17b1804b1-477c10dc259mr227480225e9.13.1764257349082; 
 Thu, 27 Nov 2025 07:29:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXF2Jfrd0OWSGimkSiPNtOzLlYSfLNaJLle9yzP7zw4R13+FE3RFl813c5Fp+yAZp/tz6LVw==
X-Received: by 2002:a05:600c:45cc:b0:475:daba:d03c with SMTP id
 5b1f17b1804b1-477c10dc259mr227479785e9.13.1764257348689; 
 Thu, 27 Nov 2025 07:29:08 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479052def4bsm67893295e9.13.2025.11.27.07.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Nov 2025 07:29:08 -0800 (PST)
Message-ID: <7ba134db-bf51-491b-91a1-588e4495b387@redhat.com>
Date: Thu, 27 Nov 2025 16:29:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/device-crash-test: ERROR_RULE_LIST garbage
 collection
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com
References: <20251127144954.3023865-1-armbru@redhat.com>
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
In-Reply-To: <20251127144954.3023865-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

On 27/11/2025 15.49, Markus Armbruster wrote:
> Device 'nand' was dropped in commit commit e86c1f967a3.
> 
> Device 'vfio-amd-xgbe' was dropped in commit aeb1a50d4a7.
> 
> Device 'vfio-calxeda-xgmac' was dropped in commit 8ebc416ac17.
> 
> The last error messages matching r"images* must be given with the
> 'pflash' parameter" was dropped in commit a2ccff4d2bc.
> 
> The error message matching r"Option '-device [\w.,-]+' cannot be
> handled by this machine" was dropped in commit commit db78a605599.
> 
> As far as I can tell, we never had message matching r"Ignoring
> smp_cpus value"

This was a wrapped string, it has been changed in comnit 
f2ad5140fa521bda30b9c3c3db5b6913f6dda1ae ("hw/arm/exynos: Convert fprintf to 
qemu_log_mask/error_report") and finally been removed in commit
7264961934130df50d151def5eb415efa2e28ec5.

> or r"MSI-X support is mandatory in the S390
> architecture".

This (split) string still exists in hw/s390x/s390-pci-bus.c:

$ grep -r -A1 MSI-X.support.is.mandatory hw/
hw/s390x/s390-pci-bus.c:            error_setg(errp, "MSI-X support is 
mandatory "
hw/s390x/s390-pci-bus.c-                       "in the S390 architecture");

So I think we should keep it.

  Thomas


