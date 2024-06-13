Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46702C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHlvF-0007jQ-Jc; Thu, 13 Jun 2024 10:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHlvE-0007jG-HL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:59:28 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHlvC-0002zq-Nd
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:59:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5F2B372DC;
 Thu, 13 Jun 2024 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718290764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9hvnwyvHl+LnE2STZGuAO8anxVKLaWZ1pj5R+R9aO0=;
 b=eBrj+xq/BSbThGcCJx8l/p6ECZuy60GitR9CXPi11vzA5Xiv7RcKCWQpatiCHlSV7mx21V
 5aHN6w2RlZ8GT5dRhaASbF5waxXnBfgF2kTjmj+2jdniBjSUnnlKpjg7nf/v+7pALtAUaO
 W+OHOMMwr9/ygy48QYg8x033DDFOIQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718290764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9hvnwyvHl+LnE2STZGuAO8anxVKLaWZ1pj5R+R9aO0=;
 b=WDekGdD8pVu9aU6mDNfnWJtZ3+UFX+pqJh5c8nlKdGLnRcL2ER/+6vAIvUX3dXYMMjw/9r
 SCTWvb6dquDtviAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DsUBDo9o;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WqWW8hEu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718290763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9hvnwyvHl+LnE2STZGuAO8anxVKLaWZ1pj5R+R9aO0=;
 b=DsUBDo9oJaB9x8wL9k1G4a3RpQ371/bgjEtwDrfIvi8ce8DF8yBOB8YC2XwJQXn6GWaSia
 KB36f7y+GgFPihiNo0sX4teVlJqBzMa8A9A2/Y6TEZ3wi6KXlbniVyKlTeXluP83uvLxPU
 uLfCfXxeGMg4o1DgxOIN62pJgBnpkio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718290763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9hvnwyvHl+LnE2STZGuAO8anxVKLaWZ1pj5R+R9aO0=;
 b=WqWW8hEuS4BnmvhlnBLJyXomQd9dP5bvHwG7qhMxrwv0nDiyJovcRJjyhiclK7EAT2XNT1
 a+RcG4WpUXrA0zCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 607D713A7F;
 Thu, 13 Jun 2024 14:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +6g7CksJa2Z0WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Jun 2024 14:59:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH 3/4] migration: Use MigrationStatus instead of int
In-Reply-To: <Zmm4z0qbv8H39pC0@x1n>
References: <20240612144228.1179240-1-peterx@redhat.com>
 <20240612144228.1179240-4-peterx@redhat.com> <Zmm4z0qbv8H39pC0@x1n>
Date: Thu, 13 Jun 2024 11:59:20 -0300
Message-ID: <87wmmsc2if.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D5F2B372DC
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jun 12, 2024 at 10:42:27AM -0400, Peter Xu wrote:
>> @@ -1544,7 +1545,7 @@ bool migration_in_postcopy(void)
>>      }
>>  }
>>  
>> -bool migration_postcopy_is_alive(int state)
>> +bool migration_postcopy_is_alive(MigrationStatus state)
>>  {
>>      switch (state) {
>>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>> @@ -1598,7 +1599,7 @@ bool migration_is_idle(void)
>>      case MIGRATION_STATUS_DEVICE:
>>      case MIGRATION_STATUS_WAIT_UNPLUG:
>>          return false;
>> -    case MIGRATION_STATUS__MAX:
>> +    default:
>>          g_assert_not_reached();
>>      }
>
> This survives the tests, but I just found that it's risky, as it's not
> covering all the states..
>
> I'll squash below when I send v2 instead.
>
> ===8<===
> From 1fc42c76294044c0ccca8841e482472486de5459 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Wed, 12 Jun 2024 10:57:26 -0400
> Subject: [PATCH] fixup! migration: Use MigrationStatus instead of int
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 9475dce7dc..706cee1b69 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1637,20 +1637,9 @@ bool migration_is_idle(void)
>      case MIGRATION_STATUS_COMPLETED:
>      case MIGRATION_STATUS_FAILED:
>          return true;
> -    case MIGRATION_STATUS_SETUP:
> -    case MIGRATION_STATUS_CANCELLING:
> -    case MIGRATION_STATUS_ACTIVE:
> -    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> -    case MIGRATION_STATUS_COLO:
> -    case MIGRATION_STATUS_PRE_SWITCHOVER:
> -    case MIGRATION_STATUS_DEVICE:
> -    case MIGRATION_STATUS_WAIT_UNPLUG:
> -        return false;
>      default:
> -        g_assert_not_reached();
> +        return false;
>      }

Unrelated, but should we consider POSTCOPY_PAUSED as idle?

> -
> -    return false;
>  }
>  
>  bool migration_is_active(void)
> -- 
> 2.45.0
>
> ===8<===

