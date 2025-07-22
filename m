Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5986C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 16:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueFVY-0004s5-Ga; Tue, 22 Jul 2025 12:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ueEnr-0003IK-Q4
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:21:18 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ueEnn-0005Kf-Tr
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:21:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:4603:0:640:d209:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8E514806A8;
 Tue, 22 Jul 2025 18:21:04 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:462::1:2e] (unknown
 [2a02:6bf:8080:462::1:2e])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3LUx984Gm4Y0-GnIIJjjR; Tue, 22 Jul 2025 18:21:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753197664;
 bh=88eE3a8ucIlDxh4qWbKEB2FGzi/n9fotq3+eh19DuzM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=tSOe4Ymb4P4XGWyvXpHaDIYrcCEJbJqrVcqSCH74eNgVBJEqB/DEC6mH754Cyuo6j
 uuNhEzW+c4ozNX9/CZJcd6M+DLAhJs3sDSDxW9pDtQyueVKfdqiiBwjmwkFnYqVNFX
 ImYzZ/WBF5SGfovK4oDXvdgBSOpjYE759fB/YisA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <46f0160b-2aeb-4052-82ef-465a62405b4d@yandex-team.ru>
Date: Tue, 22 Jul 2025 18:21:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] log: make '-msg timestamp=on' apply to all qemu_log usage
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250721185452.3016488-1-berrange@redhat.com>
 <CAJSP0QURmoyn6oZFtMOaivs3rh82-zzQ5wxmtLEG5D3jfx+Kxw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAJSP0QURmoyn6oZFtMOaivs3rh82-zzQ5wxmtLEG5D3jfx+Kxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 21.07.25 23:22, Stefan Hajnoczi wrote:
> On Mon, Jul 21, 2025 at 2:58 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> Currently the tracing 'log' back emits special code to add timestamps
>> to trace points sent via qemu_log(). This current impl is a bad design
>> for a number of reasons.
>>
>>   * It changes the QEMU headers, such that 'error-report.h' content
>>     is visible to all files using tracing, but only when the 'log'
>>     backend is enabled. This has led to build failure bugs as devs
>>     rarely test without the (default) 'log' backend enabled, and
>>     CI can't cover every scenario for every trace backend.
>>
>>   * It bloats the trace points definitions which are inlined into
>>     every probe location due to repeated inlining of timestamp
>>     formatting code, adding MBs of overhead to QEMU.
>>
>>   * The tracing subsystem should not be treated any differently
>>     from other users of qemu_log. They all would benefit from
>>     having timestamps present.
>>
>>   * The timestamp emitted with the tracepoints is in a needlessly
>>     different format to that used by error_report() in response
>>     to '-msg timestamp=on'.
>>
>> This fixes all these issues simply by moving timestamp formatting
>> into qemu_log, using the same approach as for error_report.
>>
>> The code before:
>>
>>    static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
>>    {
>>        if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
>>            if (message_with_timestamp) {
>>                struct timeval _now;
>>                gettimeofday(&_now, NULL);
>>                qemu_log("%d@%zu.%06zu:qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n",
>>                         qemu_get_thread_id(),
>>                         (size_t)_now.tv_sec, (size_t)_now.tv_usec
>>                         , creds, filename, path);
>>            } else {
>>                qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
>>            }
>>        }
>>    }
>>
>> and after:
>>
>>    static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
>>    {
>>        if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
>>            qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
>>        }
>>    }
>>
>> The log and error messages before:
>>
>>    $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
>>    2986097@1753122905.917608:qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55d925bd9490 dir=/var/home/berrange/tls
>>    2986097@1753122905.917621:qcrypto_tls_creds_get_path TLS creds path creds=0x55d925bd9490 filename=ca-cert.pem path=<none>
>>    2025-07-21T18:35:05.917626Z qemu-system-x86_64: Unable to access credentials /var/home/berrange/tls/ca-cert.pem: No such file or directory
>>
>> and after:
>>
>>    $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
>>    2025-07-21T18:43:28.089797Z qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55bf5bf12380 dir=/var/home/berrange/tls
>>    2025-07-21T18:43:28.089815Z qcrypto_tls_creds_get_path TLS creds path creds=0x55bf5bf12380 filename=ca-cert.pem path=<none>
>>    2025-07-21T18:43:28.089819Z qemu-system-x86_64: Unable to access credentials /var/home/berrange/tls/ca-cert.pem: No such file or directory
> 
> This does what Vladimir's patch did but also reduces the binary size
> and solves the #include pollution. I'll treat this as a replacement
> for Vladimir's patch.

Great, I agree.

> 
> Vladimir: Please let me know if anything is missing from this patch.
> 
>>
>> The binary size before:
>>
>>    $ ls -alh qemu-system-x86_64
>>    -rwxr-xr-x. 1 berrange berrange 87M Jul 21 19:39 qemu-system-x86_64
>>    $ strip qemu-system-x86_64
>>    $ ls -alh qemu-system-x86_64
>>    -rwxr-xr-x. 1 berrange berrange 30M Jul 21 19:39 qemu-system-x86_64
>>
>> and after:
>>
>>    $ ls -alh qemu-system-x86_64
>>    -rwxr-xr-x. 1 berrange berrange 85M Jul 21 19:41 qemu-system-x86_64
>>    $ strip qemu-system-x86_64
>>    $ ls -alh qemu-system-x86_64
>>    -rwxr-xr-x. 1 berrange berrange 29M Jul 21 19:41 qemu-system-x86_64
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   scripts/tracetool/backend/log.py | 14 +-------------
>>   util/log.c                       | 20 +++++++++++++++++++-
>>   2 files changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
>> index 17ba1cd90e..bd6739ae41 100644
>> --- a/scripts/tracetool/backend/log.py
>> +++ b/scripts/tracetool/backend/log.py
>> @@ -20,7 +20,6 @@
>>
>>   def generate_h_begin(events, group):
>>       out('#include "qemu/log-for-trace.h"',
>> -        '#include "qemu/error-report.h"',
>>           '')
>>
>>
>> @@ -36,20 +35,9 @@ def generate_h(event, group):
>>           cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
>>
>>       out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
>> -        '        if (message_with_timestamp) {',
>> -        '            struct timeval _now;',
>> -        '            gettimeofday(&_now, NULL);',
>>           '#line %(event_lineno)d "%(event_filename)s"',
>> -        '            qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
>> -        '                     qemu_get_thread_id(),',
>> -        '                     (size_t)_now.tv_sec, (size_t)_now.tv_usec',
>> -        '                     %(argnames)s);',
>> +        '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
>>           '#line %(out_next_lineno)d "%(out_filename)s"',
>> -        '        } else {',
>> -        '#line %(event_lineno)d "%(event_filename)s"',
>> -        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
>> -        '#line %(out_next_lineno)d "%(out_filename)s"',
>> -        '        }',
>>           '    }',
>>           cond=cond,
>>           event_lineno=event.lineno,
>> diff --git a/util/log.c b/util/log.c
>> index 58d24de48a..abdcb6b311 100644
>> --- a/util/log.c
>> +++ b/util/log.c
>> @@ -145,10 +145,28 @@ void qemu_log_unlock(FILE *logfile)
>>
>>   void qemu_log(const char *fmt, ...)
>>   {
>> -    FILE *f = qemu_log_trylock();
>> +    FILE *f;
>> +    g_autofree const char *timestr = NULL;
>> +
>> +    /*
>> +     * Prepare the timestamp *outside* the logging
>> +     * lock so it better reflects when the message
>> +     * was emitted if we are delayed acquiring the
>> +     * mutex
>> +     */
>> +    if (message_with_timestamp) {
>> +        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
>> +        timestr = g_date_time_format_iso8601(dt);
>> +    }
>> +
>> +    f = qemu_log_trylock();
>>       if (f) {
>>           va_list ap;
>>
>> +        if (timestr) {
>> +            fprintf(f, "%s ", timestr);
>> +        }
>> +
>>           va_start(ap, fmt);
>>           vfprintf(f, fmt, ap);
>>           va_end(ap);
>> --
>> 2.50.1
>>
>>

-- 
Best regards,
Vladimir


