Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AC2D2F7F9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KoZ-0005aN-7M; Thu, 17 Oct 2024 03:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1KoY-0005a6-3S
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1KoW-0001ea-6g
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729149650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZIc0iOxnhMih4kvkpMb6CYHszdxcf8n9pESsJHDOUMc=;
 b=YSZKaXPlyZFapcc0v2Visfne+gZJMYw6HIRqEoKxNurclnKYbUfcj+NlXXn0Zi3T1Ah0Ge
 1BuTC/RGOf/hZztAANQkmQUXx32J43hFv9Cu+fj3AeLtIfRRnI++n7Era0/49Z70ADH1Tj
 ZnJRU85aFX9MiOqZhoyMjK0+ivFaZgY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-rG_n23riNtWzIpN7Ums3sg-1; Thu, 17 Oct 2024 03:20:49 -0400
X-MC-Unique: rG_n23riNtWzIpN7Ums3sg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315544642eso4711145e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 00:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729149648; x=1729754448;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZIc0iOxnhMih4kvkpMb6CYHszdxcf8n9pESsJHDOUMc=;
 b=NXv/yOM2rNZJRPaWgeern4iqRYLWX3G4/G0KA4k247wMxLsLV4i4AOxXuJIrXRbnaN
 mxHBdBhg7kfGpCYS+NALOeC0rA67ZCsxjMA++qgVe4p2qKiw+71z8flLrur9S/Y7gRzX
 GUStyPuGT3K3zbidVsNUl7/aoDpU8M3ysBFpGyE7ZkAIdM+rd3gUWDTI3HPs7sUAB4yC
 0fXVFShvzXF0tF2qfq6D57ECKWGTZlI4lMpF48nd/Dlvs5ufDs31IXX11GLb3wj0/jUz
 dlr+ucyXSCWQ0tJMQ96V2pWHAcguQwQoWoOtuRXHgH+JxFn9aljzBuBx2fvIUycW7WJo
 cX4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuEttyoW4Gg5wAaSzHv4PyP2wyD6qXPkus7fVjy2XuoHbh7v8EXeEl4zJX1FhK1NdkVNGrHOpBfDjK@nongnu.org
X-Gm-Message-State: AOJu0YxbgXe/kcpimkWd21eBW4TEVus91SHj+nRq2bwe4eP6HA7cuLFg
 3GkrTvtljvdk3adwhnSH92qnAxVLrEWHBXZ2XyCbFu8R0+MGthg4QY7fjIX2wcS5rPMTIEst9TE
 gcC4rYxACFs/3HYjo4rdOGB9MGST5WlzlD911bHJKVmUjDrcjSLgw
X-Received: by 2002:a05:600c:1f8c:b0:42c:b220:4778 with SMTP id
 5b1f17b1804b1-4311df5c639mr186810655e9.33.1729149648058; 
 Thu, 17 Oct 2024 00:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFruC+0CS6XiZYMkeDqftlQdnXcgzn/UHwHQuPQ3HMjMZwGiSqRftlJRf5GpBkCuWSxavTuDg==
X-Received: by 2002:a05:600c:1f8c:b0:42c:b220:4778 with SMTP id
 5b1f17b1804b1-4311df5c639mr186810435e9.33.1729149647575; 
 Thu, 17 Oct 2024 00:20:47 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c35c74sm16603175e9.3.2024.10.17.00.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 00:20:47 -0700 (PDT)
Message-ID: <7e849dbe-6ffa-44f3-8a9e-ab91c234c9b5@redhat.com>
Date: Thu, 17 Oct 2024 09:20:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert most Aspeed machine tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com
References: <20241016203835.2222792-1-clg@redhat.com>
 <8b228e20-619f-4c52-a9bc-3a878a9ab34a@redhat.com>
 <c7b4442c-5356-4000-bda3-e7239c3eddde@redhat.com>
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
In-Reply-To: <c7b4442c-5356-4000-bda3-e7239c3eddde@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 17/10/2024 09.09, Cédric Le Goater wrote:
> On 10/17/24 08:06, Thomas Huth wrote:
>> On 16/10/2024 22.38, Cédric Le Goater wrote:
>>> This is a simple conversion of the tests with some cleanups and
>>> adjustments to match the new test framework. Replace the zephyr image
>>> MD5 hashes with SHA256 hashes while at it.
>>>
>>> The SDK tests depend on a ssh class from avocado.utils which is
>>> difficult to replace. To be addressed separately.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
...
>>> -    @skipUnless(*has_cmd('swtpm'))
>>> -    def test_arm_ast2600_evb_buildroot_tpm(self):
>>> -        """
>>> -        :avocado: tags=arch:arm
>>> -        :avocado: tags=machine:ast2600-evb
>>> -        """
>>> -
>>> -        image_url = ('https://github.com/legoater/qemu-aspeed-boot/raw/ 
>>> master/'
>>> -                     'images/ast2600-evb/buildroot-2023.02-tpm/flash.img')
>>> -        image_hash = 
>>> ('a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
>>> -        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
>>> -                                      algorithm='sha256')
>>> -
>>> -        # force creation of VM object, which also defines self._sd
>>> -        vm = self.vm
>>> -
>>> -        socket = os.path.join(self._sd.name, 'swtpm-socket')
>>> -
>>> -        subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
>>> -                        '--tpmstate', f'dir={self.vm.temp_dir}',
>>> -                        '--ctrl', f'type=unixio,path={socket}'])
>>> -
>>> -        self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
>>> -        self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
>>> -        self.vm.add_args('-device',
>>> -                         'tpm-tis- 
>>> i2c,tpmdev=tpm0,bus=aspeed.i2c.bus.12,address=0x2e')
>>> -        self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00', 
>>> 'Aspeed AST2600 EVB')
>>> -
>>> -        exec_command_and_wait_for_pattern(self,
>>> -            'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/ 
>>> new_device',
>>> -            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)');
>>> -        exec_command_and_wait_for_pattern(self,
>>> -            'cat /sys/class/tpm/tpm0/pcr-sha256/0',
>>> -            
>>> 'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0');
>>> -
>>> -        self.do_test_arm_aspeed_buildroot_poweroff()
>>>   class AST2x00MachineSDK(QemuSystemTest, LinuxSSHMixIn):
>>
>> You also copied AST2x00MachineMMC but you didn't remove it from the 
>> avocado test yet, so there is a hunk missing here, I think?
> 
> oh. yes, I should remove it from the avocado test.
> 
> I was initially hesitating on having multiple test_arm_aspeed.py files:
> one per machine or one per fw image type. This to set the timeout more
> precisely in the meson.build file, since the SDK FW takes longer to
> boot, and also to handle more complex test scenarios, like the SDK.
> 
> What would be your recommandation ?

If the tests do not share anything at all (neither common python code, nor 
the same firmware binary asset), I think it's maybe better to put them into 
separate files, indeed. That way we can also run the tests in parallel when 
you add "-j$(nproc)" to your "make check-functional" line.

> Btw, I have been trying to rewrite the LinuxSSHMixIn class with a
> minimal ssh Session class. It is not trivial :/

:-(

Did you peek at tests/vm/basevm.py ? I was hoping we could lent some code 
there...

...
>>> +    def test_ast1030_zephyros_1_04(self):
>>> +        kernel_name = "ast1030-evb-demo/zephyr.elf"
>>> +        zip_file = self.ASSET_ZEPHYR_1_04.fetch()
>>> +        with ZipFile(zip_file, 'r') as zf:
>>> +                     zf.extract(kernel_name, path=self.workdir)
>>> +        kernel_file = os.path.join(self.workdir, kernel_name)
>>> +
>>> +        self.set_machine('ast1030-evb')
>>
>> It's slightly better to do the set_machine() at the very top of the 
>> function. set_machine() can cancel the test in case the machine is not 
>> available in the QEMU binary, so this should best be done before fetching 
>> and extracting any assets.
> 
> Should set_machine() be the first call of a test function ?

Yes, either set_machine() or require_netdev() should be at the very top, 
since they could cancel the test.

  Thomas


