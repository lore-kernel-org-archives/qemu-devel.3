Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D27C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizni-0004Y2-Va; Mon, 04 Aug 2025 14:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1uixbl-0007zx-J6
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:00:28 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1uixbj-0007MQ-WB
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:00:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C573B211D1;
 Mon,  4 Aug 2025 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754323212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Zrkiu1M01Uabe/lgUNlKN7ug6w86sIQZ6avW71bVBI=;
 b=SeW9EhtRaUDznDUE8cNvwZUNzN/fs42cij+mAjFDx6/mPICDn/cMgHnm1RrzzxAq5jw4kh
 Ui277He2o8aAvy8hvYNMvOo8aVOtR9EivN8tnw/Df5FKWfvsOMuPnqs4cOu07Gig9cdJLt
 HfH3iKZz09QDuUEN3ZF0i+7aGyQ1MVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754323212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Zrkiu1M01Uabe/lgUNlKN7ug6w86sIQZ6avW71bVBI=;
 b=CO/R2bHezdyaznXOmgV4MSrdDN3HoLFHlOL0qsBXIwFtIUvduztgVCTQUJSxDkTFT6dl4z
 Aw321tb6trd6KAAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GQ4MJm5p;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NF41KGU3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754323210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Zrkiu1M01Uabe/lgUNlKN7ug6w86sIQZ6avW71bVBI=;
 b=GQ4MJm5plqkUWA3qoZl/9l1Z0Qo1l4tkJwQs/eFD1znTsoBxzympPqLmLl1N0MPhIK6hHh
 02gCMpOEhy//CAaK/Y+kgzULDnZk2lGS4Ttt6dFhfKpU63UFuiOsiZef8/VgwfENtA/Dfa
 bgnxJa5OaF1otEH8J918Tx2rZBH8++I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754323210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Zrkiu1M01Uabe/lgUNlKN7ug6w86sIQZ6avW71bVBI=;
 b=NF41KGU3k2MRtIR3JXbFnDRVkOAH9QxNmbbd+9uYWhKc0RFy3/aIrq0tipiYNZfn1Q3J+R
 OngcTyfZ0qPrrGDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F536133D1;
 Mon,  4 Aug 2025 16:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QMg5JAnZkGjFAQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Mon, 04 Aug 2025 16:00:09 +0000
Message-ID: <d18fc5c3-b68a-4afe-86b7-e1687780b67c@suse.de>
Date: Mon, 4 Aug 2025 18:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/17] accel/system: Introduce hwaccel_enabled() helper
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-2-mohamed@unpredictable.fr>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20250804142326.72947-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C573B211D1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.99 / 50.00]; BAYES_HAM(-2.98)[99.92%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[23]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,linaro.org,philjordan.eu,ddn.com,habkost.net,ynddal.dk,microsoft.com,intel.com,csgraf.de,nongnu.org,huawei.com,apple.com];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
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

On 8/4/25 16:23, Mohamed Mediouni wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> hwaccel_enabled() return whether any hardware accelerator
> is available.

Available or enabled?

Ciao,

Claudio



