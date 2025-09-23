Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CBECAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 11:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v110w-0003fK-GK; Tue, 23 Sep 2025 07:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v110s-0003eI-67
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v110b-00049e-Kw
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758626186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjyYjLRPSv22rCsXR1hMeAMrVZioKbGm0F5xZ+m+jlQ=;
 b=K4RIssQmk2BXYa6FJ4DwUT2MwUY5CpHmZQALMs2Cx+OJdINJ2epQstA56c9MjrwUyuGZDN
 Bt0BbNFfy3Lbob3+Yd4LbPtDhDtriOgaXu4OfFdVLoLMDRhOhWWtjM5GPI6/3OAiKHpQ5Q
 oH5xkYyh4xgd9T9OrZn0/dPrmbCjNyA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-WIgsPGtIPR28JxkGtwtMbw-1; Tue,
 23 Sep 2025 07:16:23 -0400
X-MC-Unique: WIgsPGtIPR28JxkGtwtMbw-1
X-Mimecast-MFC-AGG-ID: WIgsPGtIPR28JxkGtwtMbw_1758626182
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99F351956086; Tue, 23 Sep 2025 11:16:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F12701800452; Tue, 23 Sep 2025 11:16:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 454F021E6A27; Tue, 23 Sep 2025 13:16:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com,  berrange@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH v3 02/13] tcg: Fix error reporting on mprotect() failure
 in tcg_region_init()
In-Reply-To: <6ebc31f0-c6cf-4e14-a87d-5b59f6c6105f@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 23 Sep 2025 11:41:03
 +0200")
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-3-armbru@redhat.com>
 <6ebc31f0-c6cf-4e14-a87d-5b59f6c6105f@linaro.org>
Date: Tue, 23 Sep 2025 13:16:18 +0200
Message-ID: <87h5wta071.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 23/9/25 11:09, Markus Armbruster wrote:
>> tcg_region_init() calls one of qemu_mprotect_rwx(),
>> qemu_mprotect_rw(), and mprotect(), then reports failure with
>> error_setg_errno(&error_fatal, errno, ...).
>>
>> The use of &error_fatal is undesirable.  qapi/error.h advises:
>>
>>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>>   * exit(), because that's more obvious.
>>
>> The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
>> wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
>> mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
>> with error_report().  VirtualProtect() doesn't set errno.  mprotect()
>> does, but error_report() may clobber it.
>>
>> Fix tcg_region_init() to report errors only when it calls mprotect(),
>> and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
>> reporting otherwise.  Use error_report(), not error_setg().
>>
>> Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protect=
ion)
>> Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/region.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>> diff --git a/tcg/region.c b/tcg/region.c
>> index 7ea0b37a84..2181267e48 100644
>> --- a/tcg/region.c
>> +++ b/tcg/region.c
>> @@ -832,13 +832,16 @@ void tcg_region_init(size_t tb_size, int splitwx, =
unsigned max_threads)
>>              } else {
>>  #ifdef CONFIG_POSIX
>>                  rc =3D mprotect(start, end - start, need_prot);
>> +                if (rc) {
>> +                    error_report("mprotect of jit buffer: %s",
>> +                                 strerror(errno));
>
> I'm not keen on handling errors differently in the same function.
>
> qemu_mprotect_rwx() and qemu_mprotect_rw() already print the error.

Yes: they call qemu_mprotect__osdep(), which uses error_report().

> Why not add qemu_mprotect() as a simple qemu_mprotect__osdep() alias,
> then call it here, also covering the non-POSIX case?
> (Question for Richard, after looking at commits 22c6a9938f7 and more
>  importantly 97a83753c9 -- wondering about WoA).

There is no commit 97a83753c9.  Do you mean a97a83753c9?

I'd like to merge this commit as is.  It's a minimal fix, and it's been
reviewed.  We can always improve on top.

>> +                }
>>  #else
>>                  g_assert_not_reached();
>>  #endif
>>              }
>>              if (rc) {
>> -                error_setg_errno(&error_fatal, errno,
>> -                                 "mprotect of jit buffer");
>> +                exit(1);
>>              }
>>           }
>>           if (have_prot !=3D 0) {


