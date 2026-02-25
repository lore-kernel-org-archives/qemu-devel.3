Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFACFD377D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 18:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvJaR-00078H-U2; Wed, 25 Feb 2026 13:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vvJaQ-000783-EQ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 13:26:14 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vvJaO-0006Z1-P6
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 13:26:14 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D63145C074;
 Wed, 25 Feb 2026 18:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772043971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exV1YB7x68ODAOe4hm4gxb4jfRAlZetQiEYRrH3g1nQ=;
 b=cgQELWz2gjDnNOs+wdoqUZv+29tcP8XEkhG3i+reGZ42ZzrjWmq7RK9BfJkeTYyywZeqMR
 NCu7CSEZNRqu1a1Mgkt6TTjeyk4wlZinYt1ExxkNyxt5ThJHSyTic923L6Zk0lZ1SJX02U
 4IIoz9iDx9XUPY5L3tkViVJuGWGSO5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772043971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exV1YB7x68ODAOe4hm4gxb4jfRAlZetQiEYRrH3g1nQ=;
 b=r+OUFiVltIT9NzYGaKuaOoFwyNAXYFrHcZ+YgBNodedYcNH6J+K4Fv57j1r9A9PCxWqMQi
 yH8Mc7794G3ye0Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772043970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exV1YB7x68ODAOe4hm4gxb4jfRAlZetQiEYRrH3g1nQ=;
 b=ZEtcL/6dcSzFJkEcu2JZ72ACHyQTJAtwowCKxsP9vYnPFlrPq13FFkLM4mTIfuEBQyZ5+I
 5s7N2KWbDjgvavT2M4CetEvpVwymtNdgq8U5KMznARSslw/0kqZ4sten4SEpByWyYrCPXQ
 pw6rNTo5+l3hz6yuNNf0neKiOXO8Q7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772043970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exV1YB7x68ODAOe4hm4gxb4jfRAlZetQiEYRrH3g1nQ=;
 b=q6xLu5vI0qaQlA2PIxaaEF7jpiWltu+ux3NCVUkkfj/B0uwPI/QwGKJz3Tnci02YvyLVI6
 HcJdbSM4An2qnYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 455ED3EA65;
 Wed, 25 Feb 2026 18:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qRqsAsI+n2mVUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 25 Feb 2026 18:26:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Jason Wang
 <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>, =?utf-8?Q?Cl=C3=A9men?=
 =?utf-8?Q?t?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 16/16] tests/qtest/test-x86-cpuid-compat: Remove the
 test with the i440fx-2.9 machine
In-Reply-To: <20260225092024.794595-17-thuth@redhat.com>
References: <20260225092024.794595-1-thuth@redhat.com>
 <20260225092024.794595-17-thuth@redhat.com>
Date: Wed, 25 Feb 2026 15:26:07 -0300
Message-ID: <87bjhc3cjk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
> The machine has been removed, so the related test can now be removed, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/test-x86-cpuid-compat.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
> index 5e0547e81b7..c534e764f82 100644
> --- a/tests/qtest/test-x86-cpuid-compat.c
> +++ b/tests/qtest/test-x86-cpuid-compat.c
> @@ -343,17 +343,6 @@ int main(int argc, char **argv)
>                     "486", "xlevel2=0xC0000002,xstore=on",
>                     NULL, "xlevel2", 0xC0000002);
>  
> -    /* Check compatibility of old machine-types that didn't
> -     * auto-increase level/xlevel/xlevel2: */
> -    if (qtest_has_machine("pc-i440fx-2.9")) {
> -        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
> -                       "Conroe", NULL, "pc-i440fx-2.9",
> -                       "level", 10);
> -        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/on",
> -                       "Conroe", "erms=on", "pc-i440fx-2.9",
> -                       "level", 10);
> -    }
> -
>      /* Test feature parsing */
>      add_feature_test("x86/cpuid/features/plus",
>                       "486", "+arat",

Reviewed-by: Fabiano Rosas <farosas@suse.de>

