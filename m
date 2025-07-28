Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18565C87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 09:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKTR-0006Ww-GE; Mon, 28 Jul 2025 05:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKQ0-0005SC-BB
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:45:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKPw-0005af-Bo
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:45:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4563a57f947so20394785e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753695910; x=1754300710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0AMRES9SpZg9Mv04TE3HgQ0H5nL2Q+KNyhO0rZblGMY=;
 b=yMymX3LGYDrNFt69ISxtyppS6x3pA4UiKY1CSL3GKEkHPpvVlyG1ZLF9yeM9bIbJzq
 lPXHGKWL9FQlZzMBBhv6tJTt/t+AfX3btgdl0FkhIztkqTdtINOeFZgC+sV7Ho83qp3f
 Mcm399b+sShDS2e8FuqvD0oUR1/DLrvxuQBi1KqjsRz6A4ttCzSMQjBJNzuP3lxMq/5E
 9yH1KaVGXibGF5u3jwYGTVKyjJ37Vty6/UO+zTNyxf+yBroqm8kzK9gYZ/HD0i88fA/c
 DZa4N16CmRCoq6MGPDZif7bHTP0eLaS+gmzzuUAebQKL74XjVddms478qlfY3JmjHmHW
 j9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753695910; x=1754300710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0AMRES9SpZg9Mv04TE3HgQ0H5nL2Q+KNyhO0rZblGMY=;
 b=gCNNKVZ26m0YS+POtCpsApokp1EfcB2HeZTYhgYTgLi8M49Qy9g3huIu/IXpHexj0P
 lpN0cEy/HrcM7kze835HOA+3erelNkLLe+2lGNUWsP3uzdZJD86t2ESHvWhXFm8ck9mo
 gZ9LSZBJgaNrit8La0RvzMU7hUGKpib5yhxy6JC3tL4M1Bi5OfcLkod4ZiXq2cEITa+R
 Lx0gTDY8+wmRy0+jJYuyyag3mclz23gxWU++R83tsg3b4uxhnjP+5kc/oLK7yhR5FmcB
 KtZt5OCisqSwxyxVAms2ni0PcqnhSkxVs5tKu0yH+cEV7PvGfCiJHI+xAUp/4jqLjvBs
 fNyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUmQTX4GZ60yPHH0KumUfWaEDMAF4gi1mWAdpB4c2NoY/lIR15MJ4ST8CbAe4sa1IRa2EN4ARfSCpU@nongnu.org
X-Gm-Message-State: AOJu0YxpVv485vB8O0I7O9ZNDUPnPQ/zYALynLkcDKu7fswyI5dYUcaG
 VyVuHlV2RcYlqGafaQyOD1gUaXjKgb5xMArnj8V6oc9h3e1XACwnV/WCc2BncA+6pdk=
X-Gm-Gg: ASbGncvHMk4j1Tw6WLNwGZYv4KGmKtxAlS447/SneMh/t+Pz6FZNXfMPEqFJwRVrfT8
 VH+JSdAlrjYwdZIOIsU7kPQJFxK+AUCvzVwT8yq1Ejs2I4j3ojkdoQC9CVVx5xxXOo4OOCD6RIi
 U5KaJVWLxwbWr0dsQVm0eeOsJlmtuCowQeQAcNJ6vhI8baPQ75ll2oMRL795gm7pJhPcV0lxQ3h
 8oJOy196rxWEx6PGT1R56RCvxWAw0F7V/DgwQeJVznCcwKcXvdxi+veHCXr8M5myHuv/Ef6diA3
 dS1cvFOTojsNmcp53m/gvp5++/gJySr/n0fc/CI3E90edqlyXL4wRe8W2lEFivQraHHCDglVhIJ
 9lGUEWDJxRW/o63LjpTCK9WWMlcWS3CWcf+H4fozswCoeyetuKWbzzxwo6Vj/jO89WA==
X-Google-Smtp-Source: AGHT+IHxd6mNb0FlDVYeLdRfMQueMqqZ5becktq2llPtUhKCuL7V8PaetqSeCRdr6ad/zeMqWHqydw==
X-Received: by 2002:a05:600c:c11c:b0:456:15be:d113 with SMTP id
 5b1f17b1804b1-45870504402mr101372365e9.1.1753695909704; 
 Mon, 28 Jul 2025 02:45:09 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054f686sm147188335e9.14.2025.07.28.02.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 02:45:09 -0700 (PDT)
Message-ID: <77b04455-ce24-4c68-bdb8-b96d4f78a144@linaro.org>
Date: Mon, 28 Jul 2025 11:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: expose sys.argv to unittest.main
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250725144142.3041931-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250725144142.3041931-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/7/25 16:41, Alex Bennée wrote:
> With this we can call the supported we can take advantage of the

~~we can call the supported~~

> argument the module supports:
> 
>    env PYTHONPATH=/home/alex/lsrc/qemu.git/python:/home/alex/lsrc/qemu.git/tests/functional ./pyvenv/bin/python /home/alex/lsrc/qemu.git/tests/functional/test_aarch64_kvm.py --help
>    usage: test_aarch64_kvm.py [-h] [-v] [-q] [--locals] [--durations N] [-f] [-c] [-b] [-k TESTNAMEPATTERNS] [tests ...]
> 
>    positional arguments:
>      tests                a list of any number of test modules, classes and test methods.
> 
>    options:
>      -h, --help           show this help message and exit
>      -v, --verbose        Verbose output
>      -q, --quiet          Quiet output
>      --locals             Show local variables in tracebacks
>      --durations N        Show the N slowest test cases (N=0 for all)
>      -f, --failfast       Stop on first fail or error
>      -c, --catch          Catch Ctrl-C and display results so far
>      -b, --buffer         Buffer stdout and stderr during tests
>      -k TESTNAMEPATTERNS  Only run tests which match the given substring
> 
>    Examples:
>      test_aarch64_kvm.py test_module               - run tests from test_module
>      test_aarch64_kvm.py module.TestClass          - run tests from module.TestClass
>      test_aarch64_kvm.py module.Class.test_method  - run specified test method
>      test_aarch64_kvm.py path/to/test_file.py      - run tests from test_file.py
> 
>    usage: test_aarch64_kvm.py discover [-h] [-v] [-q] [--locals] [--durations N] [-f] [-c] [-b] [-k TESTNAMEPATTERNS] [-s START] [-p PATTERN] [-t TOP]
> 
>    options:
>      -h, --help            show this help message and exit
>      -v, --verbose         Verbose output
>      -q, --quiet           Quiet output
>      --locals              Show local variables in tracebacks
>      --durations N         Show the N slowest test cases (N=0 for all)
>      -f, --failfast        Stop on first fail or error
>      -c, --catch           Catch Ctrl-C and display results so far
>      -b, --buffer          Buffer stdout and stderr during tests
>      -k TESTNAMEPATTERNS   Only run tests which match the given substring
>      -s, --start-directory START
>                            Directory to start discovery ('.' default)
>      -p, --pattern PATTERN
>                            Pattern to match tests ('test*.py' default)
>      -t, --top-level-directory TOP
>                            Top level directory of project (defaults to start directory)
> 
>    For test discovery all test modules must be importable from the top level directory of the project.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/qemu_test/testcase.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


