Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C018EE01EF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9JT-0000bf-JO; Tue, 10 Sep 2024 18:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1so9JQ-0000Jd-CE; Tue, 10 Sep 2024 18:26:16 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1so9JO-00009o-1r; Tue, 10 Sep 2024 18:26:15 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 97CEE1F837;
 Tue, 10 Sep 2024 22:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726007165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xyKU/vmnk31FcTe/MsOvbzJI78hDjVUhHHGOtjP8OL4=;
 b=Uw2TIwurMWwrXhFc8ZEDLaHSFKjWsOWdy5g4ZfwyzXlyZJIX0QbJ2JjXnutnFeFqkkDheX
 LboU7fwlbdqoxeBXZWm9i6uy71vhiFM+caKc1ypvV/uLEakczT10a0Fvpgo1V8NEDn6MWJ
 oPtxW+eqcgWIELFiduuueQ7Rqp79LNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726007165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xyKU/vmnk31FcTe/MsOvbzJI78hDjVUhHHGOtjP8OL4=;
 b=thBj5R5tCaylH/cQy9u92YD6gqaoN8WJKCM0oO2+EyrNIkTqb2W6TCv1pm2194xDQ5846w
 1AzHpA3lY2Y59uBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OfGUfAHm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GFI0CEfj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726007164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xyKU/vmnk31FcTe/MsOvbzJI78hDjVUhHHGOtjP8OL4=;
 b=OfGUfAHm/MLJluU8DNo+wJZ3HR15vrr4c1nygO9wkcAxfKNV/yzIfg3U25Gbn1M9WMwJp3
 pr3OzD1ncXh41vRKYO7Z/8DQsDb5e1CkS4loYWgEKvpt9CUU0XULBnd2g3hsyhP8ya3MwI
 P3in5dibnETCM0FR1FujLFLD4dTWsDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726007164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xyKU/vmnk31FcTe/MsOvbzJI78hDjVUhHHGOtjP8OL4=;
 b=GFI0CEfjgoLr2GcKjjlN24Y5lwQdxzsjekbGhLNFdLG7ZrNABA8Xf2mDv72hG5LnRfmijp
 FOzcuqyVVH4o5gAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD6FC132CB;
 Tue, 10 Sep 2024 22:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7OZUKnvH4GYbOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Sep 2024 22:26:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones"
 <rjones@redhat.com>, Joel Stanley <joel@jms.id.au>, Kevin Wolf
 <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Corey Minyard <minyard@acm.org>, Eric Farman
 <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Keith Busch
 <kbusch@kernel.org>, WANG Xuerui <git@xen0n.name>, Hyman Huang
 <yong.huang@smartx.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-riscv@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Jesper Devantier
 <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell
 <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard
 Henderson <richard.henderson@linaro.org>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier
 <lvivier@redhat.com>, Rob Herring <robh@kernel.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org, "Maciej S. Szmigiero"
 <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org, Daniel Henrique
 Barboza <danielhb413@gmail.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Nina
 Schoetterl-Glausch
 <nsg@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Helge Deller
 <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, Marcelo Tosatti <mtosatti@redhat.com>, David
 Gibson <david@gibson.dropbear.id.au>, Aurelien Jarno
 <aurelien@aurel32.net>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Yanan
 Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Klaus Jensen
 <its@irrelevant.dk>, Jean-Christophe Dubois <jcd@tribudubois.net>, Jason
 Wang <jasowang@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 21/39] migration: replace assert(false) with
 g_assert_not_reached()
In-Reply-To: <20240910221606.1817478-22-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-22-pierrick.bouvier@linaro.org>
Date: Tue, 10 Sep 2024 19:26:01 -0300
Message-ID: <87mskfqh6u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 97CEE1F837
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 50.00]; BAYES_HAM(-2.99)[99.94%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 FREEMAIL_CC(0.00)[intel.com,redhat.com,jms.id.au,nongnu.org,acm.org,linux.ibm.com,kernel.org,xen0n.name,smartx.com,linux.vnet.ibm.com,gmail.com,wdc.com,ericsson.com,dabbelt.com,defmacro.it,vivier.eu,linaro.org,vger.kernel.org,euphon.net,habkost.net,oracle.com,gmx.de,ventanamicro.com,daynix.com,gibson.dropbear.id.au,aurel32.net,linux.alibaba.com,huawei.com,irrelevant.dk,tribudubois.net];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 R_RATELIMIT(0.00)[to_ip_from(RLwj7s7tgqfu86bszdfmfm6eyh)];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_GT_50(0.00)[64];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  migration/dirtyrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 1d9db812990..a28c07327e8 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -228,7 +228,7 @@ static int time_unit_to_power(TimeUnit time_unit)
>      case TIME_UNIT_MILLISECOND:
>          return -3;
>      default:
> -        assert(false); /* unreachable */
> +        g_assert_not_reached(); /* unreachable */
>          return 0;
>      }
>  }

You could drop the comment that's now redundant.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

