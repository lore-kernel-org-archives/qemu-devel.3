Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB46CC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 18:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjrg-00014q-HE; Mon, 10 Jun 2024 14:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sGjre-00013w-DW
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:35:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sGjrc-0008WO-Cf
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:35:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 79EF71FF85;
 Mon, 10 Jun 2024 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718044526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jY+qQHsQibR4tVqDw40vWC86soeztoaHszZwv/0ufSc=;
 b=y46PqZuLPKoWAPX2IYbimUlCFAL8MevLr9Uf23ekMjhT8A04fpmgUDUvqywpSdud7s16PA
 FGCxw165IOZU9AzYWRNLuc1NnDPio75XBsIgu7/0z4cw+wPHehQcmmGxTePf14SZu9V/Xu
 jCHPEGi0koLANhByUnCw78hbjN7oRkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718044526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jY+qQHsQibR4tVqDw40vWC86soeztoaHszZwv/0ufSc=;
 b=VV2r0ddR9z0Vtc/W8vF34jVQpeREaiON1Y6P2N0FDC6lIa7AhObbN6TR4oa+20cHMZuFUK
 iDszvvWlzB3TNODA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718044526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jY+qQHsQibR4tVqDw40vWC86soeztoaHszZwv/0ufSc=;
 b=y46PqZuLPKoWAPX2IYbimUlCFAL8MevLr9Uf23ekMjhT8A04fpmgUDUvqywpSdud7s16PA
 FGCxw165IOZU9AzYWRNLuc1NnDPio75XBsIgu7/0z4cw+wPHehQcmmGxTePf14SZu9V/Xu
 jCHPEGi0koLANhByUnCw78hbjN7oRkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718044526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jY+qQHsQibR4tVqDw40vWC86soeztoaHszZwv/0ufSc=;
 b=VV2r0ddR9z0Vtc/W8vF34jVQpeREaiON1Y6P2N0FDC6lIa7AhObbN6TR4oa+20cHMZuFUK
 iDszvvWlzB3TNODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EED6C13A7F;
 Mon, 10 Jun 2024 18:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YujVLG1HZ2ZlCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 10 Jun 2024 18:35:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, peterx@redhat.com
Cc: yuan1.liu@intel.com, pbonzini@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, thuth@redhat.com, armbru@redhat.com,
 lvivier@redhat.com, linuxarm@huawei.com, linwenkai6@hisilicon.com,
 zhangfei.gao@linaro.org, huangchenghai2@huawei.com
Subject: Re: [PATCH v2 4/7] migration/multifd: Add UADK initialization
In-Reply-To: <20240607135310.46320-5-shameerali.kolothum.thodi@huawei.com>
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
 <20240607135310.46320-5-shameerali.kolothum.thodi@huawei.com>
Date: Mon, 10 Jun 2024 15:35:23 -0300
Message-ID: <87o788wsr8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Shameer Kolothum via <qemu-devel@nongnu.org> writes:

> Initialize UADK session and allocate buffers required. The actual
> compression/decompression will only be done in a subsequent patch.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>


