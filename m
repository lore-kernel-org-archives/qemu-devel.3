Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A82AC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3JL-0004jb-7s; Fri, 14 Jun 2024 05:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sI3JJ-0004iJ-8q; Fri, 14 Jun 2024 05:33:29 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sI3JF-0007Ny-Rt; Fri, 14 Jun 2024 05:33:29 -0400
Content-Type: multipart/alternative;
 boundary="------------xrJ8DxpDnc0EUnjuWUElMLlc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1718357602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bijNzxYLv9HMvmlAHhEVBb1QAaXrSD1tL9FWhswhn34=;
 b=Obahux/M9EhVGSXCKTkcQNQAgHG7SB/rZcdDaauPPY1gJgoJmx1W3T1AiF/XFwoOifZi6q
 TmbU2SgZ/oz5cczPjvsoqdGZG7Dcv+69jtPwFchGrBqY5UIwzlbQxm/slKPkl/l6owJYc7
 2JgjZoZ15PnjiHQ/n8j5dm2IAClxLMc=
Message-ID: <d78740ad-e233-4e5f-9773-ff26a8ea9801@swemel.ru>
Date: Fri, 14 Jun 2024 12:33:21 +0300
MIME-Version: 1.0
Subject: Re: *** MAY_BE_SPAM !!! *** Re: [PATCH]
 tests/qtest/fuzz/virtio_net_fuzz.c: fix virtio_net_fuzz_multi
Content-Language: en-US
To: Alexander Bulekov <alxndr@bu.edu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, sdl.qemu@linuxtesting.org
References: <20240523102813.396750-2-frolov@swemel.ru>
 <20240613155448.5m6zuv2idqbbpnf2@mozz.bu.edu>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <20240613155448.5m6zuv2idqbbpnf2@mozz.bu.edu>
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------xrJ8DxpDnc0EUnjuWUElMLlc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.06.2024 18:54, Alexander Bulekov wrote:
> This fixes the almost-immediate timeout issue for me on the
> virtio_net_fuzz target, but I'm not sure why this works or if it is
> fixing the right problem:
>
> qtest_probe_child is designed to run from a libqtest process which
> uses waitpid on the PID of the child (qemu) process (stored in
> QTestState->qemu_pid) . With qemu-fuzz we do not have a separate
> libqtest and qemu process:
>
> (gdb) p s->qemu_pid
> $1 = 0
>
> So we are calling waitpid with pid = 0. From the man-page:
> "0 meaning wait for any child process whose process group ID is equal to
> that of the calling process at the time of the call to waitpid()."
>
> And we are calling it with WNOHANG. So I would expect that this almost
> always returns 0 unless some adjacent thread has changed state
> (libfuzzer uses extra threads to manage timeouts).
According to 
https://www.redhat.com/en/blog/hardening-qemu-through-continuous-security-testing#:~:text=each%20input%20is%20executed%20within%20a%20forked%20child%20process
"each input is executed within a forked child process".
According to crash reports, an error occurs first (which may be different),
followed by the crash with message "assertion timer != NULL failed". To 
my opinion, waiting for an answer from dead children is the reason of 
crashes.
> I'm happy that the fuzzer works again, and am happy to leave a review,
> but I would like to first understand what the behavior of
> qtest_probe_child here is, since it isn't really designed to work with
> the fuzzer.
>
> On 240523 1328, Dmitry Frolov wrote:
>> If QTestState was already CLOSED due to error, calling qtest_clock_step()
>> afterwards makes no sense and only raises false-crash with message:
>> "assertion timer != NULL failed".
>>
>> Signed-off-by: Dmitry Frolov<frolov@swemel.ru>
>> ---
>>   tests/qtest/fuzz/virtio_net_fuzz.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
>> index e239875e3b..2f57a8ddd8 100644
>> --- a/tests/qtest/fuzz/virtio_net_fuzz.c
>> +++ b/tests/qtest/fuzz/virtio_net_fuzz.c
>> @@ -81,6 +81,9 @@ static void virtio_net_fuzz_multi(QTestState *s,
>>           /* Run the main loop */
>>           qtest_clock_step(s, 100);
>>           flush_events(s);
>> +        if (!qtest_probe_child(s)) {
>> +            return;
>> +        }
>>   
>>           /* Wait on used descriptors */
>>           if (check_used && !vqa.rx) {
>> -- 
>> 2.43.0
>>

--------------xrJ8DxpDnc0EUnjuWUElMLlc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    On 13.06.2024 18:54, Alexander Bulekov wrote:<br>
    <blockquote type="cite"
      cite="mid:20240613155448.5m6zuv2idqbbpnf2@mozz.bu.edu">
      <pre class="moz-quote-pre" wrap="">This fixes the almost-immediate timeout issue for me on the
virtio_net_fuzz target, but I'm not sure why this works or if it is
fixing the right problem:

qtest_probe_child is designed to run from a libqtest process which
uses waitpid on the PID of the child (qemu) process (stored in
QTestState-&gt;qemu_pid) . With qemu-fuzz we do not have a separate
libqtest and qemu process:

(gdb) p s-&gt;qemu_pid
$1 = 0

So we are calling waitpid with pid = 0. From the man-page:
"0 meaning wait for any child process whose process group ID is equal to
that of the calling process at the time of the call to waitpid()."

And we are calling it with WNOHANG. So I would expect that this almost
always returns 0 unless some adjacent thread has changed state
(libfuzzer uses extra threads to manage timeouts).
</pre>
    </blockquote>
    According to
<a class="moz-txt-link-freetext" href="https://www.redhat.com/en/blog/hardening-qemu-through-continuous-security-testing#:~:text=each%20input%20is%20executed%20within%20a%20forked%20child%20process">https://www.redhat.com/en/blog/hardening-qemu-through-continuous-security-testing#:~:text=each%20input%20is%20executed%20within%20a%20forked%20child%20process</a><br>
    "each input is executed within a forked child process".<br>
    According to crash reports, an error occurs first (which may be
    different), <br>
    followed by the crash with message <span
    style="white-space: pre-wrap">"assertion timer != NULL failed".
To my opinion, waiting for an answer from dead children is the reason of crashes.
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite"
      cite="mid:20240613155448.5m6zuv2idqbbpnf2@mozz.bu.edu">
      <pre class="moz-quote-pre" wrap="">I'm happy that the fuzzer works again, and am happy to leave a review,
but I would like to first understand what the behavior of
qtest_probe_child here is, since it isn't really designed to work with
the fuzzer.

On 240523 1328, Dmitry Frolov wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">If QTestState was already CLOSED due to error, calling qtest_clock_step()
afterwards makes no sense and only raises false-crash with message:
"assertion timer != NULL failed".

Signed-off-by: Dmitry Frolov <a class="moz-txt-link-rfc2396E" href="mailto:frolov@swemel.ru">&lt;frolov@swemel.ru&gt;</a>
---
 tests/qtest/fuzz/virtio_net_fuzz.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
index e239875e3b..2f57a8ddd8 100644
--- a/tests/qtest/fuzz/virtio_net_fuzz.c
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -81,6 +81,9 @@ static void virtio_net_fuzz_multi(QTestState *s,
         /* Run the main loop */
         qtest_clock_step(s, 100);
         flush_events(s);
+        if (!qtest_probe_child(s)) {
+            return;
+        }
 
         /* Wait on used descriptors */
         if (check_used &amp;&amp; !vqa.rx) {
-- 
2.43.0

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------xrJ8DxpDnc0EUnjuWUElMLlc--

