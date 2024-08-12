Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF55C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 15:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdXKR-0000GS-NU; Mon, 12 Aug 2024 11:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1sdXKP-0000F6-IH
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:51:25 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1sdXKN-0004Ei-QH
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:51:25 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78F552225D;
 Mon, 12 Aug 2024 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723477879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFsrH/pZgcNQlZiKQHa6fge04k3gm6FZdwmeLpIIr+s=;
 b=t3jcQIRUBuIzWyGCOpXyGLMlBm9qsVaDvbiMgzVvrhXxyaFXbrlypjDNlRzlpdnFyyN3kY
 9XFqE+cTuocbM0k9VzMeqlnwAAfcyR8Dyg6C7N+E7sYxruaHMOLW3E8hKZ8fYGF6TF4wJY
 2vbHEeMPhN4SAviFBOF9OUoBztG/bLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723477879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFsrH/pZgcNQlZiKQHa6fge04k3gm6FZdwmeLpIIr+s=;
 b=aqK2g9zEbNBwNLNP+C0ToGMJNJCKCH9A0KbK9bg7PJhJ3Tm369NgeJ8qM1eJ2EXGXPYjmv
 LV7RHLd+dmLScwBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723477879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFsrH/pZgcNQlZiKQHa6fge04k3gm6FZdwmeLpIIr+s=;
 b=t3jcQIRUBuIzWyGCOpXyGLMlBm9qsVaDvbiMgzVvrhXxyaFXbrlypjDNlRzlpdnFyyN3kY
 9XFqE+cTuocbM0k9VzMeqlnwAAfcyR8Dyg6C7N+E7sYxruaHMOLW3E8hKZ8fYGF6TF4wJY
 2vbHEeMPhN4SAviFBOF9OUoBztG/bLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723477879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFsrH/pZgcNQlZiKQHa6fge04k3gm6FZdwmeLpIIr+s=;
 b=aqK2g9zEbNBwNLNP+C0ToGMJNJCKCH9A0KbK9bg7PJhJ3Tm369NgeJ8qM1eJ2EXGXPYjmv
 LV7RHLd+dmLScwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D27E137BA;
 Mon, 12 Aug 2024 15:51:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /5xIDXcvumaqLAAAD6G6ig
 (envelope-from <cfontana@suse.de>); Mon, 12 Aug 2024 15:51:19 +0000
Message-ID: <4a96a578-7501-4624-9699-fe6a91150253@suse.de>
Date: Mon, 12 Aug 2024 17:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] module: Move local_err initialization to the loop
 in module_load_qom_all()
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, kraxel@redhat.com,
 laurent@vivier.eu, mjt@tls.msk.ru
References: <20240812085725.1093540-1-alexander.ivanov@virtuozzo.com>
 <20240812085725.1093540-2-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20240812085725.1093540-2-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Claudio Fontana <cfontana@suse.de>

On 8/12/24 10:57, Alexander Ivanov wrote:
> Move local_err initialization inside the loop in the module_load_qom_all()
> function. This change ensures that the error variable is reset to NULL for
> each iteration of the loop. This prevents triggering assert(*errp == NULL)
> failure in error_setv() when local_err is reused in the loop.
> 
> Note: The local_err variable is freed in error_report_err() so there is no
> any leak.
> 
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  util/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/module.c b/util/module.c
> index 32e263163c..3eb0f06df1 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -354,13 +354,13 @@ int module_load_qom(const char *type, Error **errp)
>  void module_load_qom_all(void)
>  {
>      const QemuModinfo *modinfo;
> -    Error *local_err = NULL;
>  
>      if (module_loaded_qom_all) {
>          return;
>      }
>  
>      for (modinfo = module_info; modinfo->name != NULL; modinfo++) {
> +        Error *local_err = NULL;
>          if (!modinfo->objs) {
>              continue;
>          }


