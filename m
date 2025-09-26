Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1659ACAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v244O-0005Jm-26; Fri, 26 Sep 2025 04:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v244L-0005JJ-S8
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 04:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v2449-0007NW-Sy
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 04:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758876265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Tyy58xPIK7T5L5tVWVt3UoJLE++H2jkUnTCVgoELlNA=;
 b=SF8qypF2G3zM/f+eMS+2XzUCkqKC43s8eNLq0CaStVYRmRbQ61mhNtU73Oq8RkwD+R9JGy
 R5cV8zma6DCx8y5yIYRpYE7+EMJC2T60RSxAI80jxPYuX24I7Aw9E7tq/FFdtC/ZMoDHSR
 ME5Xr7pyz5qCQEadu7WcaruJ6ZIifSM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-U2SD21qbO_qwj8vfXgGWuA-1; Fri, 26 Sep 2025 04:44:24 -0400
X-MC-Unique: U2SD21qbO_qwj8vfXgGWuA-1
X-Mimecast-MFC-AGG-ID: U2SD21qbO_qwj8vfXgGWuA_1758876263
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f93db57449so923989f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 01:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758876263; x=1759481063;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tyy58xPIK7T5L5tVWVt3UoJLE++H2jkUnTCVgoELlNA=;
 b=pQlUaLJsFdxSaJ90PcyGp5Gautekmi1ievWcOW0UX6f1Z/frkaUQH2kILM6DhvN/vr
 ev5P2wsK5AtOhrjvW9ZZvKA3guijO26Qs2cgF/u7pLbsTtFUOF1pEILsep20LBHLPgtw
 3DleFjhSMUhGKPlJttsPahf9E8prjqIXrzGrGJKRQ8OoxsARaLHXC5iJYoxp7tojS/+x
 /TDl5rB1fhjiik/EHKEnmyNObtGRdszJGnfBTRilsmGH3RuvvPY28OYVt/+L1pzbKtvk
 W8kCpWJvj1hpowqYQM8gnIK8fNvGMRvOYcS29OvNTBShqcx0+qM3wd0kwxK/ept7bLDr
 6RMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrcJQJVm4ZcO8PE3D4GugQQ27BKGBdSl2/NlT4srCe1/xS7TeJwOJQGmBujxl9rbIraQaVQPFFEXu4@nongnu.org
X-Gm-Message-State: AOJu0Yw0QwQ9CgndRaoj9gQZ+oJo8yW176TQJLmsz4GN3MyWPaFSH3f5
 q45rUvjSfu2tnyPD3PgvSmCOqxQypfkajmGwuV/LLzSSABX9QWrfz86FYEmdFkzFL9HO+Jw/8Sf
 nWsrTxFijzzr9YEMqKtjAvTUOg1SIMrLiJqMsaC4SyejcqwDAo2/r0c+4
X-Gm-Gg: ASbGncvcicZawE1gAXNdogOG1xmhOOuulOhTfo5cN4hTDqIWYgwSI7swaaMBP6D4HM+
 ErRSjYZoVXGpf7U4lRVn+H1IYJ8H0g7JmSs8vpyE40NkY606MFKgM0/3uvVQABnilN34AIh/KBZ
 PqgnOsJOyeFvHLO25+zRghrAF2SZnVlL224PQNeys1Wd/BaZag/MpsOsckH40wtZDWUI45G2rWU
 y5IcchuvmZT4ZEWqUmVppv6lSfpjtvQkzhbSw7uwxbKOx3PA+nQKeQvEEB+Iz++V3pqoerNln86
 5lvhs4ldlRUsqXkR/XKvgHsJq9gA07yWB4qGbmryocIBnXwODhwuJprOcUrTrnC/FOprtqIZ+hY
 +hCyrmg==
X-Received: by 2002:adf:e6ce:0:b0:411:f07a:67fb with SMTP id
 ffacd0b85a97d-411f07a6bb4mr2813201f8f.55.1758876262691; 
 Fri, 26 Sep 2025 01:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRdRKXWmz9BjJGP8JfHE/ep/LLEANwNFVTiMSYihh18kNlnlgpDjVEcV3gNkgCfBqqjiPngQ==
X-Received: by 2002:adf:e6ce:0:b0:411:f07a:67fb with SMTP id
 ffacd0b85a97d-411f07a6bb4mr2813174f8f.55.1758876262240; 
 Fri, 26 Sep 2025 01:44:22 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc9248f56sm6323879f8f.61.2025.09.26.01.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 01:44:21 -0700 (PDT)
Message-ID: <ec28971b-fe8c-4a6a-b241-10ff1468c991@redhat.com>
Date: Fri, 26 Sep 2025 10:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-9-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250926051542.104432-9-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/09/2025 07.15, Gustavo Romero wrote:
> This commit removes Avocado as a dependency for running the
> reverse_debugging test.
> 
> The main benefit, beyond eliminating an extra dependency, is that there
> is no longer any need to handle GDB packets manually. This removes the
> need for ad-hoc functions dealing with endianness and arch-specific
> register numbers, making the test easier to read. The timeout variable
> is also removed, since Meson now manages timeouts automatically.
> 
> reverse_debugging now uses the pygdbmi module to interact with GDB, if
> it's available in the test environment, otherwise the test is skipped.
> GDB is detect via the QEMU_TEST_GDB env. variable.
> 
> This commit also significantly improves the output for the test and
> now prints all the GDB commands used in sequence. It also adds
> some clarifications to existing comments, for example, clarifying that
> once the replay-break is reached, a SIGINT is captured in GDB.
> 
> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
> won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
> before running 'make check-functional' or 'meson test [...]'.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
...
> @@ -53,49 +55,11 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
>           vm.launch()
>           return vm
>   
> -    @staticmethod
> -    def get_reg_le(g, reg):
> -        res = g.cmd(b'p%x' % reg)
> -        num = 0
> -        for i in range(len(res))[-2::-2]:
> -            num = 0x100 * num + int(res[i:i + 2], 16)
> -        return num
> -
> -    @staticmethod
> -    def get_reg_be(g, reg):
> -        res = g.cmd(b'p%x' % reg)
> -        return int(res, 16)
> -
> -    def get_reg(self, g, reg):
> -        # value may be encoded in BE or LE order
> -        if self.endian_is_le:
> -            return self.get_reg_le(g, reg)
> -        else:
> -            return self.get_reg_be(g, reg)
> -
> -    def get_pc(self, g):
> -        return self.get_reg(g, self.REG_PC)
> -
> -    def check_pc(self, g, addr):
> -        pc = self.get_pc(g)
> -        if pc != addr:
> -            self.fail('Invalid PC (read %x instead of %x)' % (pc, addr))

I think it would make sense to keep wrapper functions get_pc() and 
check_pc(), since that functionality is still used in a bunch of places 
(e.g. "gdb.cli("print $pc").get_addr()" is used a couple of times).

> @@ -124,68 +88,99 @@ def reverse_debugging(self, shift=7, args=None):
>           with Ports() as ports:
>               port = ports.find_free_port()
>               vm = self.run_vm(False, shift, args, replay_path, image_path, port)
> -        logger.info('connecting to gdbstub')
> -        g = gdb.GDBRemote('127.0.0.1', port, False, False)
> -        g.connect()
> -        r = g.cmd(b'qSupported')
> -        if b'qXfer:features:read+' in r:
> -            g.cmd(b'qXfer:features:read:target.xml:0,ffb')
> -        if b'ReverseStep+' not in r:
> +
> +        try:
> +            logger.info('Connecting to gdbstub...')
> +            self.reverse_debugging_run(vm, port, last_icount)
> +            logger.info('Test passed.')
> +        except GdbTimeoutError:
> +            self.fail("Connection to gdbstub timeouted...")

I'm not a native English speaker, but I think "timeout" is not a verb. So 
maybe better: "Timeout while connecting to gdbstub" or something similar?

> +    @skipIfMissingEnv("QEMU_TEST_GDB")

Somehow this SKIP is always triggered on my system, even if I correctly 
pointed "configure" to the right GDB with the "--gdb" option ... not sure 
why this happens, but I'll try to find out...

  Thomas


