Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C2FC52D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 18:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbOgv-0004qI-Oj; Tue, 06 Aug 2024 14:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sbOgt-0004p9-O1
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 14:13:47 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sbOgr-0004Le-HR
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 14:13:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DAE8421C21;
 Tue,  6 Aug 2024 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722968022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=deTBkenlhG3l1gcLbRLqKf8okNa4wxuu1rQipFVcjNs=;
 b=FOBzTdEeClJ4BvF7cLi37vD2xCHWFrJQ0FpyByOEIkc7ZNfSrxOnbRN7zagsByuQml618l
 mh47iFTe15EsrD4olSh0Ug/sGJq8TTKjoU1FWtuiMpxDl4J3jHz91vURuaJMB7QGuFz01E
 hpnigX1ffs1FsgAFe5YTAzorDOaggz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722968022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=deTBkenlhG3l1gcLbRLqKf8okNa4wxuu1rQipFVcjNs=;
 b=I5kD5pBWhC0Lt+jcOqTLe2nRBoyo4URUTLpie+qpO6OnBBMrPkMjkcUmd/7Od9GCYwRR48
 0c0MSOSxh7ldmiCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722968021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=deTBkenlhG3l1gcLbRLqKf8okNa4wxuu1rQipFVcjNs=;
 b=cxR4AwKGsUvReiFPO7yJbAGfwtY+Gu83NbyoTr1oWmluTdfIaClsO20i7GKn7GzRNSrpJg
 UZfMAmujo4wA/72g9UQLUd2Dw504VskJGAevh8ca9IEAPQZI2Foi9lBYqv8g4q97h1fYOT
 Frg2LhI2b8xCIkUF/sfXMAJpxVND290=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722968021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=deTBkenlhG3l1gcLbRLqKf8okNa4wxuu1rQipFVcjNs=;
 b=eSE7KBLGaCo8bwbKKHe6daaYsQiEC5obbVe/WJ1PBL8TnyJdrZSBS6YB2hZif4Hkx/mGl1
 d3bTQJypw3njuAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65C1C13929;
 Tue,  6 Aug 2024 18:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id amhcC9VnsmYpHQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 06 Aug 2024 18:13:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yong.huang@smartx.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, yong.huang@smartx.com
Subject: Re: [PATCH 1/2] tests/migration: Nitpick the inconsistent parameters
In-Reply-To: <2c2a9e1ade9265f708530029b967e160fab74b6b.1722957352.git.yong.huang@smartx.com>
References: <cover.1722957352.git.yong.huang@smartx.com>
 <2c2a9e1ade9265f708530029b967e160fab74b6b.1722957352.git.yong.huang@smartx.com>
Date: Tue, 06 Aug 2024 15:13:38 -0300
Message-ID: <87bk25h63x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.30 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  tests/migration/guestperf/comparison.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/migration/guestperf/comparison.py b/tests/migration/guestperf/comparison.py
> index 42cc0372d1..40e9d2eb1d 100644
> --- a/tests/migration/guestperf/comparison.py
> +++ b/tests/migration/guestperf/comparison.py
> @@ -127,7 +127,7 @@ def __init__(self, name, scenarios):
>      # varying numbers of channels
>      Comparison("compr-multifd", scenarios = [
>          Scenario("compr-multifd-channels-4",
> -                 multifd=True, multifd_channels=2),
> +                 multifd=True, multifd_channels=4),
>          Scenario("compr-multifd-channels-8",
>                   multifd=True, multifd_channels=8),
>          Scenario("compr-multifd-channels-32",

Reviewed-by: Fabiano Rosas <farosas@suse.de>

