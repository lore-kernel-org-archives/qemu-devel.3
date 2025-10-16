Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183ADCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 07:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9IFZ-0005S6-IK; Thu, 16 Oct 2025 03:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9IFX-0005RW-MO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 03:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9IFU-00028b-6c
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 03:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760599085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1vGt7Q70KB3nhImkZzA1sZaPIGiOe1pJumTRXrSOcdY=;
 b=KtRYk4kwnzaXE31buRRzegIXi/kSA2Ci+dKs5bWvn8f8muIQBFiQ/owUhQVDmGeXWtVZkw
 PylVmJcZj05R6ttjIzHG7e+0ifVkyf/H9Cqayqnc6JD8X8AwRUzI2f8gHD+1rS0HnwG4Lx
 x7Y5h++W7WSw7Inphp8lft27Lx18NR0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-wZiNM-LlPaibUTco82x5MQ-1; Thu, 16 Oct 2025 03:18:03 -0400
X-MC-Unique: wZiNM-LlPaibUTco82x5MQ-1
X-Mimecast-MFC-AGG-ID: wZiNM-LlPaibUTco82x5MQ_1760599083
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47114018621so1075825e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 00:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760599083; x=1761203883;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1vGt7Q70KB3nhImkZzA1sZaPIGiOe1pJumTRXrSOcdY=;
 b=uIHS4NJHYWW3ql4XI1rGfS+rpp9sqhMKwdCltC9ntmPbOiRnjL3fb56+KDti4LdhlU
 eRQnmyGWHeWbJ24fafzZxEIfkS5eTwGuPNbIHmGdNVT0ZukSnhuf3y0FONiCNw/3WWNv
 YUPPTNQRyrEH/bTxVaGbVL8N/28K62SdwPQnv17wEiaMDTeD6N0erHLdgaS+BLj80Gmz
 W1C3sV+p8dGHsGcA627Csn6DHRdDwzJj1w253yKKBzFw1V8EsBWo3Tb8GtXmLbZXpGQD
 UR1qcQjwUYA4+K45cyBg4oQ6/5V7OhXeXdOORfdE6tcGLhkwaDZW5dScA28IZWMJUXr3
 X49Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR0wgyuyjXImaVgaT/U7NclV1G8iXn4nzHcoZj7wTYZ4SC5bzSBt2Hhdn7TxsGGOO8nZnWSEjkb6Xc@nongnu.org
X-Gm-Message-State: AOJu0YxH+asp3H7JVZldA8u5PS5jJh4o+NhWPxviQy97njxLUS0qNbB5
 1ovMGoxRL8s58Kp/ZAAtlHwd+pYAz1YSmZWmiK/f+Rz3OY2gvRpPPwBubSZPtyxhZRe87g6e9Ty
 hr45NF0H8NfPH2IYUYKsVOEj5WoIVbt7rK2wKfSgi/SkEWGGh+OqTIUcS
X-Gm-Gg: ASbGncvqAYPMFasgjBilo5OOchB0ZZc4xFUXIDaAKGsaTZX54U0uDuk69ZZTfUoP8FU
 J7mv+th5u853NeAjhKp11QpZcHkQgC38ChfBPpKgzTmCS0lA+bFZJ/dLG6XJ1pWTHbK47adDa15
 fFEgcAMeHzEVwL2rQp4Wrfgu6Jq7mKYpq+0K6BwnAvTKS2OPvkEGXemWzpnEq+V8QXfbknhz6HE
 kGsqx/LKziIljTH4mvIDgutExCDCpnwq9z0Uht7UW6+dXQ0N1XcoZ9En5oVnOUdtFl9pBoGGP3d
 hUWzbcbGIAOP4Q9FSbaoW4DsF8GFDtgBsFehqcMZbxPXZL4f0WW3SknuwqjUGQ0yCOeE93m94ei
 JCUvBxJkU4pf5gYmgEIgPQ1lqKKBEnCDRFh0CHZq1
X-Received: by 2002:a05:600d:41c4:b0:471:7a:791a with SMTP id
 5b1f17b1804b1-471007a7a96mr39458385e9.7.1760599082660; 
 Thu, 16 Oct 2025 00:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbuVvqZPNENIiEDYmG02rBU0O1aMfQkW8meXbNig3SpmMshbAnd96S61PsVqBwCwcwxSnU4Q==
X-Received: by 2002:a05:600d:41c4:b0:471:7a:791a with SMTP id
 5b1f17b1804b1-471007a7a96mr39458235e9.7.1760599082270; 
 Thu, 16 Oct 2025 00:18:02 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144d17cdsm8550475e9.18.2025.10.16.00.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 00:18:01 -0700 (PDT)
Message-ID: <f4ec5b8c-2bdb-43a2-a100-cfb1685aeb52@redhat.com>
Date: Thu, 16 Oct 2025 09:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/functional: add tests for SCLP event CPI
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Michael Mueller <mimu@linux.ibm.com>
References: <20251013133902.111233-1-shalini@linux.ibm.com>
 <20251013133902.111233-2-shalini@linux.ibm.com>
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
In-Reply-To: <20251013133902.111233-2-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 13/10/2025 15.39, Shalini Chellathurai Saroja wrote:
> Add tests for SCLP event type Control-Program Identification.
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/s390x/test_ccw_virtio.py | 25 +++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
> index 453711aa0f..82e73ecf5e 100755
> --- a/tests/functional/s390x/test_ccw_virtio.py
> +++ b/tests/functional/s390x/test_ccw_virtio.py
> @@ -15,6 +15,7 @@
>   import tempfile
>   
>   from qemu_test import QemuSystemTest, Asset
> +from qemu_test import exec_command
>   from qemu_test import exec_command_and_wait_for_pattern
>   from qemu_test import wait_for_console_pattern
>   
> @@ -270,5 +271,29 @@ def test_s390x_fedora(self):
>                           'while ! (dmesg -c | grep Start.virtcrypto_remove) ; do'
>                           ' sleep 1 ; done', 'Start virtcrypto_remove.')
>   
> +        # Test SCLP event Control-Program Identification (CPI)
> +        cpi = '/sys/firmware/cpi/'
> +        sclpcpi = '/machine/sclp/s390-sclp-event-facility/sclpcpi'
> +        self.log.info("Test SCLP event CPI")
> +        exec_command(self, 'echo TESTVM > ' + cpi + 'system_name')
> +        exec_command(self, 'echo LINUX > ' + cpi + 'system_type')
> +        exec_command(self, 'echo TESTPLEX > ' + cpi + 'sysplex_name')
> +        exec_command(self, 'echo 0x001a000000060b00 > ' + cpi + 'system_level')
> +        exec_command(self, 'echo 1 > ' + cpi + 'set')

I think at least the last statement should be replaced by 
exec_command_and_wait_for_pattern, waiting for the shell prompt. Otherwise 
there is a small race condition here that the exec_command() has been sent, 
but not executed yet. Ok, the event_wait() will wait for a while, so it's 
very unlikely, but let's better play save and wait for the shell prompt 
first, before waiting for the event.

> +        try:
> +            event = self.vm.event_wait('SCLP_CPI_INFO_AVAILABLE')
> +        except TimeoutError:
> +            self.skipTest('SCLP Event type CPI is not supported')

Should we rather fail the test in case we don't receive the event?

> +        ts = self.vm.cmd('qom-get', path=sclpcpi, property='timestamp')
> +        self.assertNotEqual(ts, 0)
> +        name = self.vm.cmd('qom-get', path=sclpcpi, property='system_name')
> +        self.assertEqual(name.strip(), 'TESTVM')
> +        typ = self.vm.cmd('qom-get', path=sclpcpi, property='system_type')
> +        self.assertEqual(typ.strip(), 'LINUX')
> +        sysplex = self.vm.cmd('qom-get', path=sclpcpi, property='sysplex_name')
> +        self.assertEqual(sysplex.strip(), 'TESTPLEX')
> +        level = self.vm.cmd('qom-get', path=sclpcpi, property='system_level')
> +        self.assertEqual(level, 0x001a000000060b00)

  Thomas


