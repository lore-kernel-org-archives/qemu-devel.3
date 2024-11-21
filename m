Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D735E64006
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECRq-0004Fs-5P; Thu, 21 Nov 2024 14:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tECRd-00049A-I7
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:02:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tECRc-0006g9-3L
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732215743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mhl4JBBgEDPMNbSymbtoH0R+ERhP+4wdK9miXYr5aak=;
 b=UuGJZp8py/AKxFSLBJFBDnvxzVkFpZ9eBrafQq3TNowUeuc/jxsyJ5xYp+Mwkm53pZwEHM
 mkny/qqN0evfYrJkOfqTmWJ3N9LL1sBRa5xMNI8jYZiLJnxMrCZJsm9481nVA+8eKx+bK2
 1SYcguT3CC/HZ/VGZ5qbP8nnC+EKLa8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-vVnVSj1oMOS4jFJPt8CENg-1; Thu, 21 Nov 2024 14:02:18 -0500
X-MC-Unique: vVnVSj1oMOS4jFJPt8CENg-1
X-Mimecast-MFC-AGG-ID: vVnVSj1oMOS4jFJPt8CENg
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-53da09b1ca1so932638e87.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:02:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732215737; x=1732820537;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mhl4JBBgEDPMNbSymbtoH0R+ERhP+4wdK9miXYr5aak=;
 b=pqtP6VIe9/fPhJPbyLeYg7XyR5ZZD/E+I64fckI8csC/aH2F436uxpZgYDFsgtdnS6
 Ete3Rjd19Z5KBKFSwiTD84UWgDy22ZUdgJULKC3Tg3KclGmfpMj8enIeyrTUFOxQDbxO
 dOkw6az9MzdiryvKUkEquDMwFq2o1n+qp4PSAc6CO0pmKvI4uSf9Zgh6+DdLmjg/BnFo
 kIdkdRRhdeGZ2miZ8268reAzJtaR2MdAGzn3J+W3xltaSgvr34joM783F9xcvl9RY5Hv
 TI8XmEhrxkuoBcOGkAIpZcKi9SWrI9y55+PFilGmITph8DeBrvG4L8SllWn5Zz+X83W7
 Kb+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMjc4J4dl9ToC6niFGp7T4zpsuZtJOo8nKOfP/2BRQ8JHB3faDN/iujPbQ/tzNvEjHx/mIjo1qYsrz@nongnu.org
X-Gm-Message-State: AOJu0YyZndMkSBLE8jY3GhJ1Bhy4tOOJJwD+NpvtPAFdT09cFov1bSsI
 IYCG1RUAQF6WG0WL8Bm0mu6TALnuVFCmWD1KYxxxgXyygsvb3yrgMGf7PFg1VctjKT2jLG8AjUZ
 cV5rQYhPHyEg+tRI8+E9kkUBlo3f9zBOUUxbq8EsDWWp7D3nA2Rmh
X-Gm-Gg: ASbGnctrxj8U6BAuwv3NHYyrza5nVi4i0t+wNetWye3kucjCBHvgMLfD8fH3Un75bCs
 EPvrt3cGburQoyL2kUjMPC7e3micPzXreU5sLypVy6ymXud0d7nk7PXJ16mqAAYSWtBVk0VjJnT
 UuswhQM0jyCd1JfZixyfTMA3BZsH8sYxghgcy4M81aAPmG2c53t3Zx9LuHEQpVYTSre1DtPddTp
 uvMEOeAjzIcwn/YunBR+32YXruW1nU+iwHErOS2MgJDf+B3YiI9cK+UFdhmyViN9A8Qro3XldrJ
 akE=
X-Received: by 2002:a05:651c:50b:b0:2ff:58e5:2adc with SMTP id
 38308e7fff4ca-2ff8db6631dmr47034961fa.1.1732215737020; 
 Thu, 21 Nov 2024 11:02:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOm5sTNXAN006KhSnQMMiY0ENdCi+QikZ3fmve/50LBt4HfD4kIS8dYv3ujMDg5LK2gqygzQ==
X-Received: by 2002:a05:651c:50b:b0:2ff:58e5:2adc with SMTP id
 38308e7fff4ca-2ff8db6631dmr47034371fa.1.1732215736488; 
 Thu, 21 Nov 2024 11:02:16 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d01d3a3451sm85455a12.4.2024.11.21.11.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 11:02:16 -0800 (PST)
Message-ID: <8b027418-6555-40c5-a9e3-5fd0d66ef399@redhat.com>
Date: Thu, 21 Nov 2024 20:02:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/39] tests/functional: enable debug logging for
 QEMUMachine
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-s390x@nongnu.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <20241121165806.476008-12-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241121165806.476008-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/11/2024 17.57, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> Set the 'qemu.machine' logger to 'DEBUG' level, to ensure we see log
> messages related to the QEMUMachine class. Most importantly this
> ensures we capture the full QEMU command line args for instances we
> spawn.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20241121154218.1423005-12-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/qemu_test/testcase.py | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index f9c9de1166..e2a329c3e5 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -57,9 +57,15 @@ def setUp(self, bin_prefix):
>           self._log_fh.setFormatter(fileFormatter)
>           self.log.addHandler(self._log_fh)
>   
> +        # Capture QEMUMachine logging
> +        self.machinelog = logging.getLogger('qemu.machine')
> +        self.machinelog.setLevel(logging.DEBUG)
> +        self.machinelog.addHandler(self._log_fh)
> +
>       def tearDown(self):
>           if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
>               shutil.rmtree(self.workdir)
> +        self.machinelog.removeHandler(self._log_fh)
>           self.log.removeHandler(self._log_fh)
>   
>       def main():


Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>


