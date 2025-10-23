Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78043CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwbD-0000nA-PT; Thu, 23 Oct 2025 10:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBwaq-0000gO-8a
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:47:11 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBwam-0004SL-PM
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:47:08 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E35DB2124B;
 Thu, 23 Oct 2025 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761230819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctakP51aVcSmCO2h8NJgdYldazosEhBNepSnQoZfwe4=;
 b=N5Tbbh34iU4MkCSSEF6Q1ozjc+uDqRPV83cfTlNzpJ7/JmUDbZ3oYBGV0/o+nJnLDtOwP4
 iodxhm6epDT8vmqX60vAnXdrttXdo7dXbPOR2F4AjjGecrBTRgZotd3VF1mHPtFbDBzDaC
 oXARpSpQDbmurLNz6MYk0HOReCu6R14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761230819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctakP51aVcSmCO2h8NJgdYldazosEhBNepSnQoZfwe4=;
 b=W1VLimOFh0pCmBkpx5jGRMYG3rA7t33EjoyPab5AMqpaJJe+eOtIrpxqS7LKvrZLE8lVsU
 nj1Nod45xClZJUAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761230814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctakP51aVcSmCO2h8NJgdYldazosEhBNepSnQoZfwe4=;
 b=eexhBRPKbLMQGz1NutckSLobfLp35Bacnqy3xXxwiOhKd9ZY2rtEq7KR1mPGFvSWceAQIs
 To12Qk5y36UgPmMUXNV+5u0ABIjkE6MrE+xBmlDhTxtPkhZWcmxsYLMPxa9jvYfW26Yy8+
 mSkLeuExlf57qu8F7LU5Ezq0mKb0I08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761230814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctakP51aVcSmCO2h8NJgdYldazosEhBNepSnQoZfwe4=;
 b=vfR+t+7GBI7GhEW+bWrX/p1fdTv6C5Us206sIFF3sKVFloBM+3dLX5jSE02ZCTBh4jI0FB
 7nNtEhSSowqDYaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 605A913285;
 Thu, 23 Oct 2025 14:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H/jDCN4/+mg1dgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Oct 2025 14:46:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 14/24] migration: Use visitors in
 migrate_params_test_apply
In-Reply-To: <20251015021603.21933-1-guobin@linux.alibaba.com>
References: <20250630195913.28033-15-farosas@suse.de>
 <20251015021603.21933-1-guobin@linux.alibaba.com>
Date: Thu, 23 Oct 2025 11:46:51 -0300
Message-ID: <87v7k5smjo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,alibaba.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Bin Guo <guobin@linux.alibaba.com> writes:

> Fabiano Rosas wrote on Mon, 30 Jun 2025 16:59:03 -0300:
>
>> Convert the code in migrate_params_test_apply() from an open-coded
>> copy of every migration parameter to a copy using visitors. The
>> current code has conditionals for each parameter's has_* field, which
>> is exactly what the visitors do.
>> 
>> This hides the details of QAPI from the migration code and avoids the
>> need to update migrate_params_test_apply() every time a new migration
>> parameter is added. Both were very confusing and while the visitor
>> code can become a bit involved, there is no need for new contributors
>> to ever touch it.
>> 
>> Change the name of the function to a more direct reference of what it
>> does: merging the user params with the temporary copy.
>> 
>> Move the QAPI_CLONE_MEMBERS into the caller, so QAPI_CLONE can be used
>> and there's no need to allocate memory in the migration
>> code. Similarly, turn 'tmp' into a pointer so the proper qapi_free_
>> routine can be used.
>> 
>> An extra call to migrate_mark_all_params_present() is now needed
>> because the visitors update the has_ field for non-present fields, but
>> we actually want them all set so migrate_params_apply() can copy all
>> of them.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 157 +++++++++++++++-----------------------------
>>  1 file changed, 54 insertions(+), 103 deletions(-)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index 6619b5f21a..695bec5b8f 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> 
>> -static void migrate_params_test_apply(MigrationParameters *params,
>> -                                      MigrationParameters *dest)
>> +static bool migrate_params_merge(MigrationParameters *dst,
>> +
>> +    ...
>> +    /* read in from src */
>> +    v = qobject_output_visitor_new(&ret_out);
>> +    ok = visit_type_MigrationParameters(v, NULL, &src, errp);
>> +    if (!ok) {
>> +        goto out;
>>      }
>> +    visit_complete(v, &ret_out);
>> +    visit_free(v);
>>  
>> -    if (params->has_max_bandwidth) {
>> -        dest->max_bandwidth = params->max_bandwidth;
>> +    /*
>> +     * Write to dst but leave existing fields intact (except for has_*
>> +     * which will be updated according to their presence in src).
>> +     */
>> +    v = qobject_input_visitor_new(ret_out);
>> +    ok = visit_start_struct(v, NULL, NULL, 0, errp);
>> +    if (!ok) {
>> +        goto out;
>>      }
>> -
>> -    if (params->has_avail_switchover_bandwidth) {
>> -        dest->avail_switchover_bandwidth = params->avail_switchover_bandwidth;
>> +    ok = visit_type_MigrationParameters_members(v, dst, errp);
>> +    if (!ok) {
>> +        goto out;
>>      }
>> -
>> -    if (params->has_downtime_limit) {
>> -        dest->downtime_limit = params->downtime_limit;
>> +    ok = visit_check_struct(v, errp);
>> +    visit_end_struct(v, NULL);
>> +    if (!ok) {
>> +        goto out;
>>      }
>>  
>> -    if (params->has_x_checkpoint_delay) {
>> -        dest->x_checkpoint_delay = params->x_checkpoint_delay;
>> -    }
>> +out:
>> +    visit_free(v);
>> +    qobject_unref(ret_out);
>> +    return ok;
>> }
>
> If visit_start_struct is executed successfully, then visit_end_struct
> should be executed. IMHO:
>
>     v = qobject_input_visitor_new(ret_out);
>     ok = visit_start_struct(v, NULL, NULL, 0, errp);
>     if (!ok) {
>         goto out;
>     }
>
>     ok = visit_type_MigrationParameters_members(v, dst, errp);
>     if (!ok) {
>         goto out_end;
>     }
>
>     ok = visit_check_struct(v, errp);
>
> out_end:
>     visit_end_struct(v, NULL);
>
> out:
>     visit_free(v);
>     qobject_unref(ret_out);
>
>     return ok;
> }
>

New code after Peter's suggestions is:

+/*
+ * Merge @src over @dst by copying deep clones of the present members
+ * from @src to @dst. Non-present on @src are left untouched on @dst.
+ */
+#define QAPI_MERGE(type, dst_, src_)                                    \
+    ({                                                                  \
+        QObject *out_ = NULL;                                           \
+        Visitor *v_;                                                    \
+        /* read in from src */                                          \
+        v_ = qobject_output_visitor_new(&out_);                         \
+        visit_type_ ## type (v_, NULL, &src_, &error_abort);            \
+        visit_complete(v_, &out_);                                      \
+        visit_free(v_);                                                 \
+        /*                                                              \
+         * Write to dst but leave existing fields intact (except for    \
+         * has_* which will be updated according to their presence in   \
+         * src).                                                        \
+         */                                                             \
+        v_ = qobject_input_visitor_new(out_);                           \
+        visit_start_struct(v_, NULL, NULL, 0, &error_abort);            \
+        visit_type_ ## type ## _members(v_, dst_, &error_abort);        \
+        visit_check_struct(v_, &error_abort);                           \
+        visit_end_struct(v_, NULL);                                     \
+        visit_free(v_);                                                 \
+        qobject_unref(out_);                                            \
+    })


