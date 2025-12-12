Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE0BD59D6F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 18:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU7UI-0001eR-Ay; Fri, 12 Dec 2025 13:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vU7UH-0001eH-FJ
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 13:03:29 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vU7UF-00066E-SI
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 13:03:29 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B80BC33900;
 Fri, 12 Dec 2025 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765562605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wBdDqoBDaKc582fhWqrgdbTI4EKnEk9T/tbivIR63b0=;
 b=Bn2tvHxElqOcdbUrs6QzQeD7oq4aY1D/8LJahZN1fCYLZl31tU9/qKBnwvclfCBxhvnic5
 c8/e93yMIU4v4VOuwyYMLwmzhpNw3GBKBy83M/7msXcAXw7IITlKvfBQs5Tomo4HyYxFr8
 lmbrX4YLguGdqUDqQkLhWJnt6sl/EbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765562605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wBdDqoBDaKc582fhWqrgdbTI4EKnEk9T/tbivIR63b0=;
 b=N3Qsg3yvRehwQWtmoeMEuC5LS+KaHLUz5nmh27Pq+N14u1pD6RS8FASlP5D4qUZGNni/SD
 v2LCNRtgoDb8ypBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765562605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wBdDqoBDaKc582fhWqrgdbTI4EKnEk9T/tbivIR63b0=;
 b=Bn2tvHxElqOcdbUrs6QzQeD7oq4aY1D/8LJahZN1fCYLZl31tU9/qKBnwvclfCBxhvnic5
 c8/e93yMIU4v4VOuwyYMLwmzhpNw3GBKBy83M/7msXcAXw7IITlKvfBQs5Tomo4HyYxFr8
 lmbrX4YLguGdqUDqQkLhWJnt6sl/EbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765562605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wBdDqoBDaKc582fhWqrgdbTI4EKnEk9T/tbivIR63b0=;
 b=N3Qsg3yvRehwQWtmoeMEuC5LS+KaHLUz5nmh27Pq+N14u1pD6RS8FASlP5D4qUZGNni/SD
 v2LCNRtgoDb8ypBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BFD13EA63;
 Fri, 12 Dec 2025 18:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nHH7NuxYPGkTCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 12 Dec 2025 18:03:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Chen Baozi
 <chenbaozi@phytium.com.cn>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Mostafa Saleh
 <smostafa@google.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: Re: [RFC v6 3/4] tests/qtest/libqos: Add SMMUv3 helper library
In-Reply-To: <20251206155203.3015881-4-tangtao1634@phytium.com.cn>
References: <20251206155203.3015881-1-tangtao1634@phytium.com.cn>
 <20251206155203.3015881-4-tangtao1634@phytium.com.cn>
Date: Fri, 12 Dec 2025 15:03:22 -0300
Message-ID: <87pl8jvaqd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.27 / 50.00]; BAYES_HAM(-2.97)[99.87%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[15];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 phytium.com.cn:email]
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

Tao Tang <tangtao1634@phytium.com.cn> writes:

> Introduce qos-smmuv3, a reusable library for SMMUv3-related qtest
> operations. This module encapsulates common tasks like:
>
> - SMMUv3 initialization (enabling, configuring command/event queues)
> - Stream Table Entry (STE) and Context Descriptor (CD) setup
> - Multi-level page table construction (L0-L3 for 4KB granules)
> - Support for Stage 1, Stage 2, and nested translation modes
> - Could be easily extended to support multi-space testing infrastructure
>     (Non-Secure, Secure, Root, Realm)
>
> The library provides high-level abstractions that allow test code to
> focus on IOMMU behavior validation rather than low-level register
> manipulation and page table encoding. Key features include:
>
> - Automatic memory allocation for translation structures with proper
>     alignment
> - Helper functions to build valid STEs/CDs for different translation
>     scenarios
> - Page table walkers that handle address offset calculations per
>     security space
> - Command queue management for SMMU configuration commands
>
> This infrastructure is designed to be used by iommu-testdev-based tests
> and future SMMUv3 test suites, reducing code duplication and improving
> test maintainability.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>

To the best of my ability:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

