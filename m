Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA732C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Va-00028m-BL; Thu, 08 May 2025 09:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uD1VY-00021l-1o
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:41:52 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uD1VW-0004di-2L
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:41:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 740491F456;
 Thu,  8 May 2025 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746711707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZYlHCsvyVPDGhkLiqv88lDes1dkEu/Suwopay/eR2sE=;
 b=FloPTHvDRasDiw1u46TeAtrpzJDrYx0Ye5KJrWeU592Tv009zCJKVN08bHuhkRjWxJZ4Fy
 mJM5OzMQaRGnPmf5c3rVrGzqNdfH2j0WU2ctK8LyYbQ57Ua6dq4N4i2KvZ9/X2DzS76cDZ
 gsP0bYXt1Pp5ufDk3Et1VNAy88fyyHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746711707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZYlHCsvyVPDGhkLiqv88lDes1dkEu/Suwopay/eR2sE=;
 b=b1V3xo12MAwFeuwfDG6gmScSsAEOPFlrYGuQI55txheheqGfw0L8hzR0oejAHkMuPgiefx
 M8Z9ORX9npD94+CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746711707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZYlHCsvyVPDGhkLiqv88lDes1dkEu/Suwopay/eR2sE=;
 b=FloPTHvDRasDiw1u46TeAtrpzJDrYx0Ye5KJrWeU592Tv009zCJKVN08bHuhkRjWxJZ4Fy
 mJM5OzMQaRGnPmf5c3rVrGzqNdfH2j0WU2ctK8LyYbQ57Ua6dq4N4i2KvZ9/X2DzS76cDZ
 gsP0bYXt1Pp5ufDk3Et1VNAy88fyyHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746711707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZYlHCsvyVPDGhkLiqv88lDes1dkEu/Suwopay/eR2sE=;
 b=b1V3xo12MAwFeuwfDG6gmScSsAEOPFlrYGuQI55txheheqGfw0L8hzR0oejAHkMuPgiefx
 M8Z9ORX9npD94+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2BF813687;
 Thu,  8 May 2025 13:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id adJBI5q0HGjDPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 08 May 2025 13:41:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Danie?=
 =?utf-8?Q?l_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] tests/qtest/q35-test: Remove the obsolete
 test_without_smram_base test
In-Reply-To: <20250508095122.144807-1-thuth@redhat.com>
References: <20250508095122.144807-1-thuth@redhat.com>
Date: Thu, 08 May 2025 10:41:43 -0300
Message-ID: <87h61vfcdk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> With the release of QEMU 10.1, the pc-q35-4.1 machine will be older
> than 6 years and thus will get disabled automatically by the
> MACHINE_VER_DELETION() macro. Remove the related test to avoid
> that the q35-test is failing when the machine is not available anymore.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/q35-test.c | 37 +------------------------------------
>  1 file changed, 1 insertion(+), 36 deletions(-)
>
> diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
> index 75d4078b790..62fff49fc89 100644
> --- a/tests/qtest/q35-test.c
> +++ b/tests/qtest/q35-test.c
> @@ -246,41 +246,6 @@ static void test_smram_smbase_lock(void)
>      qtest_quit(qts);
>  }
>  
> -static void test_without_smram_base(void)
> -{
> -    QPCIBus *pcibus;
> -    QPCIDevice *pcidev;
> -    QTestState *qts;
> -    int i;
> -
> -    qts = qtest_init("-M pc-q35-4.1");
> -
> -    pcibus = qpci_new_pc(qts, NULL);
> -    g_assert(pcibus != NULL);
> -
> -    pcidev = qpci_device_find(pcibus, 0);
> -    g_assert(pcidev != NULL);
> -
> -    /* check that RAM is accessible */
> -    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
> -    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
> -
> -    /* check that writing to 0x9c succeeds */
> -    for (i = 0; i <= 0xff; i++) {
> -        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
> -        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == i);
> -    }
> -
> -    /* check that RAM is still accessible */
> -    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN + 1);
> -    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, (SMRAM_TEST_PATTERN + 1));
> -
> -    g_free(pcidev);
> -    qpci_free_pc(pcibus);
> -
> -    qtest_quit(qts);
> -}
> -
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -293,6 +258,6 @@ int main(int argc, char **argv)
>      qtest_add_data_func("/q35/tseg-size/ext/16mb", &tseg_ext_16mb,
>                          test_tseg_size);
>      qtest_add_func("/q35/smram/smbase_lock", test_smram_smbase_lock);
> -    qtest_add_func("/q35/smram/legacy_smbase", test_without_smram_base);
> +
>      return g_test_run();
>  }

Queued, thanks!

