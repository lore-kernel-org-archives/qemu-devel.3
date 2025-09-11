Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F368ACAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 18:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwlm6-0005YX-JW; Thu, 11 Sep 2025 14:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlm3-0005Xe-Ss
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:11:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlm0-00053m-9E
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:11:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b9c35bc0aso8930595e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757614314; x=1758219114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7vBGxmVL5EksCtKsKGW1T+0Zk1CbZYN7YHH4nGByQnw=;
 b=V5FqgNdo6fpCs/xy1V2186qch6IjnF+eUyz6xY5RwXS1QfB+6ZRg7tgm94cjqjE9aL
 GOa3n+HuZl8jT2tojnO2hk9zagnEpEovwi8RfUqnHv7XdMLFWqeLqlq38srXu0/Bpx9m
 0W18u2G3BhF2/25OY9UidIEfWWVaE2cRubssgJXpPyPxLbTrzTOMZ4lo0tvpzmdpgDZz
 /B1iYY7grCVxq2f1Ju8FVuWgZGr49JltnD+BRYUEg7CiHekM/PYxsy0wvB9uWCiEcQvL
 bu6iOdVkrcYLoydYMIFuhxsG/SZ3ATDRAEOxyzLkA2dCb/l+I6Cg+gJOx5A5egamdyI1
 9OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757614314; x=1758219114;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7vBGxmVL5EksCtKsKGW1T+0Zk1CbZYN7YHH4nGByQnw=;
 b=xRjPzGcgnihqO49O+XOH/WjelfYzOjckUMZZDAdGuR/GIEgHCeRSSS1nf7b+pGRWiA
 n+pmhSFVzvcS4AFv2d9EtZ+Jl8j3MFfbzQWSERoMPCPIMJNLAw4OzubBVM9FAMLJAfJP
 75QBws+YbnfTyKYnJty0CnDzPja/Wc9VYYQfGgXhnjLwTxBYctNUQ+432G1cHS1WpDyX
 OZL+goygLacGvS9cYSpFSPRTooRPgxtq5V2AC6H4W2wPBIL50H/Uty8tP3XeiMcXEVzy
 SdavMmy6sBjuiO+7AzfXlAuebkOKfI+OOcEaRQW+kPBLB2xiP6qsMfXGM0XWC82ZHr/C
 2I3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8iJHif/XM7pGYVvFIopxcExkJq35qhu3skKISi34O3ZOlZfxhVbMKud5khIuEx4PgCp8ykWWkNjJF@nongnu.org
X-Gm-Message-State: AOJu0Yyk3SIxfVkgAKHnJCbEjdkPq5qRmRrQv6RVDl3efOFAZirtu8pJ
 AaFuiaBG5X3sidpJrsQRbAzP7t7zEKAbJtK5Ln41qDjXYDPyudkNaQpfD/+E9XBDYbc=
X-Gm-Gg: ASbGncttg1tc2/pxaEwXPVtJ/N2UbwRUYr/pD/jE9L1AKnIz+aGBnckXObE50n9I2D1
 tdJWoEJr+x96IShKQfeXpPgcjKvPCeIZJmCFSwkSZYCvxhgN57lzYXhSbgm5muAjiXb/i/qg5+p
 PTYnC3ISoI1ldzAcX+DgzsWC9Onj1zetJFEJKj6v9dqZgsNcYhTZm326T+ODjz2bMoVLirmltTH
 d1F8RIwpli201+oewGfD9EuY/ayNsxDz6zYa0S6srHgeOFOrEucWlwcUbUzlxzpstGYCXVDDKTT
 uCvaDn8yMSwUtOdNB7GaVp6JAmYxKxfb7UTkanANxtRX8l6iB14ipFlr1eULTFJBSpI/LNNoEuH
 O+AJec8PP80E1uayvYvKYmtzfSBI+IF3DX41Gph8fzDCjgb6xb51uVcYL0VeOcyargIT3
X-Google-Smtp-Source: AGHT+IFAIAqU6Nuvap9JUvSXanNk06mWDtfgRMVxaCy6E8/sYjTBMW5vPQHRTsuc99Xx+9IP/KTr7g==
X-Received: by 2002:a05:600c:1d2a:b0:45c:b5f7:c6e7 with SMTP id
 5b1f17b1804b1-45f215641ddmr962425e9.0.1757614314394; 
 Thu, 11 Sep 2025 11:11:54 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037c9d91sm31034385e9.20.2025.09.11.11.11.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 11:11:53 -0700 (PDT)
Message-ID: <0d867b92-2419-4cfd-91ca-752a95407537@linaro.org>
Date: Thu, 11 Sep 2025 18:11:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/20] util: add support for formatting thread info in
 messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-20-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-20-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> --- a/storage-daemon/qemu-storage-daemon.c
> +++ b/storage-daemon/qemu-storage-daemon.c
> @@ -47,6 +47,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/config-file.h"
>   #include "qemu/error-report.h"
> +#include "qemu/message.h"
>   #include "qemu/help_option.h"
>   #include "qemu/job.h"
>   #include "qemu/log.h"
> @@ -65,6 +66,10 @@ static const char *pid_file;
>   static char *pid_file_realpath;
>   static volatile bool exit_requested = false;
>   
> +#define QMESSAGE_FORMAT_DEFAULT \
> +    (QMESSAGE_FORMAT_PROGRAM_NAME | \
> +     QMESSAGE_FORMAT_THREAD_INFO)
> +
>   void qemu_system_killed(int signal, pid_t pid)
>   {
>       exit_requested = true;
> @@ -399,6 +404,7 @@ int main(int argc, char *argv[])
>   #endif
>   
>       error_init(argv[0]);
> +    qmessage_set_format(QMESSAGE_FORMAT_DEFAULT);
>       qemu_init_exec_dir(argv[0]);
>       os_setup_signal_handling();
>   
> diff --git a/system/vl.c b/system/vl.c
> index 9030212c50..20b655a7bc 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -145,6 +145,10 @@
>   
>   #define MAX_VIRTIO_CONSOLES 1
>   
> +#define QMESSAGE_FORMAT_DEFAULT \
> +    (QMESSAGE_FORMAT_PROGRAM_NAME | \
> +     QMESSAGE_FORMAT_THREAD_INFO)
> +
>   typedef struct BlockdevOptionsQueueEntry {
>       BlockdevOptions *bdo;
>       Location loc;
> @@ -811,10 +815,9 @@ static void realtime_init(void)
>       }
>   }
>   
> -
>   static void configure_msg(QemuOpts *opts)
>   {
> -    int flags = QMESSAGE_FORMAT_PROGRAM_NAME;
> +    int flags = QMESSAGE_FORMAT_DEFAULT;
>       if (qemu_opt_get_bool(opts, "timestamp", false)) {
>           flags |= QMESSAGE_FORMAT_TIMESTAMP;
>       }
> @@ -2888,6 +2891,7 @@ void qemu_init(int argc, char **argv)
>       module_call_init(MODULE_INIT_OPTS);
>   
>       error_init(argv[0]);
> +    qmessage_set_format(QMESSAGE_FORMAT_DEFAULT);

Worth a static initial value of the variable, rather than require two other startup calls?

This also seems like it should be a separate patch from adding THREAD_INFO to 
qmessage_context_print.


r~


>       qemu_init_exec_dir(argv[0]);
>   
>       os_setup_limits();
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 8452845f44..dc2666afe7 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -1102,7 +1102,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
>           self.vm.shutdown()
>           log = iotests.filter_qtest(self.vm.get_log())
>           log = re.sub(r'^Formatting.*\n', '', log)
> -        log = re.sub(r'^%s: ' % os.path.basename(iotests.qemu_prog), '', log)
> +        log = re.sub(r'^%s: \(\d+:\w+\): ' % os.path.basename(iotests.qemu_prog), '', log)
>   
>           self.assertEqual(log,
>                            "Can no longer replace 'img1' by 'repair0', because " +
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index 511a55b1e8..84f352d30b 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -81,7 +81,7 @@ _filter_qemu_io()
>   # replace occurrences of QEMU_PROG with "qemu"
>   _filter_qemu()
>   {
> -    gsed -e "s#\\(^\\|(qemu) \\)$(basename $QEMU_PROG):#\1QEMU_PROG:#" \
> +    gsed -e "s#\\(^\\|(qemu) \\)$(basename $QEMU_PROG): ([0-9]\+:[-_a-zA-Z]\+):#\1QEMU_PROG:#" \
>           -e 's#^QEMU [0-9]\+\.[0-9]\+\.[0-9]\+ monitor#QEMU X.Y.Z monitor#' \
>           -e $'s#\r##' # QEMU monitor uses \r\n line endings
>   }
> diff --git a/util/message.c b/util/message.c
> index 1db9254733..814ca0316e 100644
> --- a/util/message.c
> +++ b/util/message.c
> @@ -37,4 +37,11 @@ void qmessage_context_print(FILE *fp)
>               fprintf(fp, "%s: ", pgnamestr);
>           }
>       }
> +
> +    if (message_format & QMESSAGE_FORMAT_THREAD_INFO) {
> +        int thid = qemu_get_thread_id();
> +        const char *thname = qemu_thread_get_name();
> +
> +        fprintf(fp, "(%d:%s): ", thid, thname);
> +    }
>   }


