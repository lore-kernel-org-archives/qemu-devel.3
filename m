Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580DECA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 14:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzFXW-00081U-SY; Thu, 18 Sep 2025 10:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzFXR-00080Y-Op
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzFXP-0001lu-Tl
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758205384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Hc4qkmEJBJ0xlhXj7zXQTeDKkFeD/p8WCnI5AR92hw=;
 b=Wx6WUHVi89Sec3E+YCaCK8gmaiMh6uQzqkGbDm+GTl0J3ZEWjos8Vs2pQWnpqpgECo3EvY
 pCBkMXaIlnDF8I1HLGKrvacFPFs0C0U2jgXlHS6+DQ/FI001rSJ+MbTa7WDvGtr9cOxV5Q
 IsEEHa/C3jdKa+m8bh3UQgj/ebWo7vw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-oDtTs9FEOfaYJ5rPODFfWQ-1; Thu,
 18 Sep 2025 10:23:02 -0400
X-MC-Unique: oDtTs9FEOfaYJ5rPODFfWQ-1
X-Mimecast-MFC-AGG-ID: oDtTs9FEOfaYJ5rPODFfWQ_1758205381
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C72BD1800292; Thu, 18 Sep 2025 14:23:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F224318003FC; Thu, 18 Sep 2025 14:22:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8739C21E6A27; Thu, 18 Sep 2025 16:22:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 berrange@redhat.com,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 02/12] tcg: Fix error reporting on mprotect() failure
 in tcg_region_init()
In-Reply-To: <9bc5b8b1-e68a-4e39-8cbf-4205707f8317@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Thu, 18 Sep 2025 21:23:31 +0900")
References: <20250917115207.1730186-1-armbru@redhat.com>
 <20250917115207.1730186-3-armbru@redhat.com>
 <9bc5b8b1-e68a-4e39-8cbf-4205707f8317@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 18 Sep 2025 16:22:57 +0200
Message-ID: <87a52ralha.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> On 2025/09/17 20:51, Markus Armbruster wrote:
>> tcg_region_init() calls one of qemu_mprotect_rwx(),
>> qemu_mprotect_rw(), and mprotect(), then reports failure with
>> error_setg_errno(&error_fatal, errno, ...).
>> The use of &error_fatal is undesirable.  qapi/error.h advises:
>>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>>   * exit(), because that's more obvious.
>> The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
>> wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
>> mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
>> with error_report().  VirtualProtect() doesn't set errno.  mprotect()
>> does, but error_report() may clobber it.
>> Fix tcg_region_init() to report errors only when it calls mprotect(),
>> and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
>> reporting otherwise.  Use error_report(), not error_setg().
>> Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protect=
ion)
>> Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>   tcg/region.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>> diff --git a/tcg/region.c b/tcg/region.c
>> index 7ea0b37a84..74e3b4b774 100644
>> --- a/tcg/region.c
>> +++ b/tcg/region.c
>> @@ -832,13 +832,17 @@ void tcg_region_init(size_t tb_size, int splitwx, =
unsigned max_threads)
>>               } else {
>>   #ifdef CONFIG_POSIX
>>                   rc =3D mprotect(start, end - start, need_prot);
>> +                if (rc) {
>> +                    error_report("mprotect of jit buffer: %s",
>> +                                 strerror(errno));
>> +                }
>> +
>
> Nitpick: this blank line at the end of #ifdef looks strange to me.

Accident, will drop it.  Thanks!

>>   #else
>>                   g_assert_not_reached();
>>   #endif
>>               }
>>               if (rc) {
>> -                error_setg_errno(&error_fatal, errno,
>> -                                 "mprotect of jit buffer");
>> +                exit(1);
>>               }
>>           }
>>           if (have_prot !=3D 0) {


