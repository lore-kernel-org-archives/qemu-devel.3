Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB29D1AD5D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 14:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t14cT-0006xZ-Ay; Wed, 16 Oct 2024 10:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t14cQ-0006wc-3O
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 10:03:18 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t14cO-00087B-Aq
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 10:03:17 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78F3B21EAA;
 Wed, 16 Oct 2024 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729087393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KMk3Q93iT6OK8gO68Gin8tgInVrV9d1a8Qn7KfhHn0=;
 b=RvJDomAkfTl6ISXmqRFDTdSMGW0Tdoqr16tD4592VukVNHUp+ovAKf4V6jszE6w8aeBEqh
 SPSEDj13UpTkbao6KtTuyms94OUMxW14eiZafiKjrtw0D9zDQVwLerH90CkVWm90CXFj6V
 rCgfQA0FVwbSRGG0ZukiZPUO4mllDJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729087393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KMk3Q93iT6OK8gO68Gin8tgInVrV9d1a8Qn7KfhHn0=;
 b=SE8G3EKQb52i8J90lN3OfgCCp+EtTwNHfqKQOSiDuNGkdRQ3iDebNSY7Sb5/vPn0LBwh6g
 J9pfxF6WV2l4JGCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729087393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KMk3Q93iT6OK8gO68Gin8tgInVrV9d1a8Qn7KfhHn0=;
 b=RvJDomAkfTl6ISXmqRFDTdSMGW0Tdoqr16tD4592VukVNHUp+ovAKf4V6jszE6w8aeBEqh
 SPSEDj13UpTkbao6KtTuyms94OUMxW14eiZafiKjrtw0D9zDQVwLerH90CkVWm90CXFj6V
 rCgfQA0FVwbSRGG0ZukiZPUO4mllDJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729087393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KMk3Q93iT6OK8gO68Gin8tgInVrV9d1a8Qn7KfhHn0=;
 b=SE8G3EKQb52i8J90lN3OfgCCp+EtTwNHfqKQOSiDuNGkdRQ3iDebNSY7Sb5/vPn0LBwh6g
 J9pfxF6WV2l4JGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 040081376C;
 Wed, 16 Oct 2024 14:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /a4rL6DHD2fxFQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Oct 2024 14:03:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: tpm-tis-device-swtpm-test timeout
In-Reply-To: <eee403f1-058f-4222-902f-eb1e78ab54e0@linux.ibm.com>
References: <87jze9qlrp.fsf@suse.de>
 <077cee03-efd0-4716-865a-b9990afb91a3@linux.ibm.com>
 <87h69dqigg.fsf@suse.de>
 <865424c1-f79c-44ad-b70f-8bf3e455e025@linux.ibm.com>
 <87ed4hqgvl.fsf@suse.de>
 <d9b18dc6-994b-4fdb-8f6c-5cb9bd11eb64@linux.ibm.com>
 <87ed4hgh2l.fsf@suse.de>
 <eee403f1-058f-4222-902f-eb1e78ab54e0@linux.ibm.com>
Date: Wed, 16 Oct 2024 11:03:10 -0300
Message-ID: <87bjzkgn6p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Stefan Berger <stefanb@linux.ibm.com> writes:

> On 10/15/24 6:02 PM, Fabiano Rosas wrote:
>> Stefan Berger <stefanb@linux.ibm.com> writes:
>> 
>>> On 10/15/24 3:57 PM, Fabiano Rosas wrote:
>>>> Stefan Berger <stefanb@linux.ibm.com> writes:
>>>>
>>>
>>>>>
>>>>> So this here is failing for you every time?
>>>>>
>>>>> QTEST_QEMU_BINARY=build/qemu-system-aarch64
>>>>> ./build/tests/qtest/tpm-tis-device-swtpm-test
>>>>
>>>> Sorry, I was unclear. No, that runs for about 30 iterations before it
>>>> fails. I just ran each of these in a terminal window:
>>>>
>>>> $ for i in $(seq 1 999); do echo "$i =============";  QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/tpm-tis-device-swtpm-test || break ; done
>>>
>>> On my Fedora 40 host this command line here alone has been running for
>>> 250 loop iterations now and is still continuing.
>>>
>>>> $ make -j$(nproc) check
>>>
>>> So this needs to be run in parallel to the above command line to cause
>>> the failure?
>>>
>> 
>> Yes, I've been using that method to reproduce live migration race
>> conditions as well. It's quite effective.
>> 
>> If you don't think you'll be able to find the root cause due to the
>> unreproducibility on your side, maybe we could at least add an assert
>> that bcount is not larger than rsp_size. I think that would at least
>> give an explicit error instead of a buffer overflow.
>> 
>> I can also try to dig deeper into this when I get some time. At the
>> moment I know nothing about the tpm device emulation.
>> 
>
> The loop has run 3000 times by itself so that part is stable. However, 
> it seems there is some other test case that the loop cannot run in 
> parallel with. So, yes there is 'something'. ... ... Just having all 
> CPUs in a system busy requires waiting for migration to be complete on 
> the dst_qemu side as well. Can you try it with this patch:
>
> diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
> index fb94496bbd..b52cd44841 100644
> --- a/tests/qtest/tpm-tests.c
> +++ b/tests/qtest/tpm-tests.c
> @@ -115,6 +115,7 @@ void tpm_test_swtpm_migration_test(const char 
> *src_tpm_path,
>
>       tpm_util_migrate(src_qemu, uri);
>       tpm_util_wait_for_migration_complete(src_qemu);
> +    tpm_util_wait_for_migration_complete(dst_qemu);
>
>       tpm_util_pcrread(dst_qemu, tx, tpm_pcrread_resp,
>                        sizeof(tpm_pcrread_resp));
>
>
> For me this fixes the issue I had seen where reading the STS register 
> was done too early before all the TPM TIS state was completely restored. 
> The active locality was -1 and STS return 0xffffffff and from then on 
> things went bad.

Thanks, that fixes the issue. Could you send a patch please?

