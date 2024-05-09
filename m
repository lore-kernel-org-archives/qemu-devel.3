Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE57DC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 14:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s54og-00054m-UE; Thu, 09 May 2024 10:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s54of-00054a-Mm
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:32:13 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s54od-0005iK-S6
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:32:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20F6838752;
 Thu,  9 May 2024 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715265130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBkvD8bdm1D7PAV4LlihF0KXZAm9mbaWmTOgMz6uOnA=;
 b=JhktrUPEFS/ShRHnOdBlIQ6R1hku+VeU+8mdgIMiJRWx6aklEnqm0vW9sIf9TV+9giDg6S
 4Fx8UafrMC75uXzkMFozxhbt/WvM2a7g59HTNnJsCzuxcbZ1e1cBOoSQLb4iN1D9MwNO1y
 jMFFSOA40n1nZRLm2+N8aN+rKgBOrYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715265130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBkvD8bdm1D7PAV4LlihF0KXZAm9mbaWmTOgMz6uOnA=;
 b=LGWgoAUXg0W9YIAp+KJLqQw7Xaz8geXt1n7xXNjsfqlCw9IErHKuw8iJOhxmJaka5QqKyT
 eVkIiHTyoG/KuPDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JhktrUPE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LGWgoAUX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715265130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBkvD8bdm1D7PAV4LlihF0KXZAm9mbaWmTOgMz6uOnA=;
 b=JhktrUPEFS/ShRHnOdBlIQ6R1hku+VeU+8mdgIMiJRWx6aklEnqm0vW9sIf9TV+9giDg6S
 4Fx8UafrMC75uXzkMFozxhbt/WvM2a7g59HTNnJsCzuxcbZ1e1cBOoSQLb4iN1D9MwNO1y
 jMFFSOA40n1nZRLm2+N8aN+rKgBOrYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715265130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBkvD8bdm1D7PAV4LlihF0KXZAm9mbaWmTOgMz6uOnA=;
 b=LGWgoAUXg0W9YIAp+KJLqQw7Xaz8geXt1n7xXNjsfqlCw9IErHKuw8iJOhxmJaka5QqKyT
 eVkIiHTyoG/KuPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 984E213941;
 Thu,  9 May 2024 14:32:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a46YF2nePGYmBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 May 2024 14:32:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 09/26] migration: vmstate_register_named
In-Reply-To: <874jb7kqya.fsf@suse.de>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-10-git-send-email-steven.sistare@oracle.com>
 <874jb7kqya.fsf@suse.de>
Date: Thu, 09 May 2024 11:32:07 -0300
Message-ID: <871q6bkqe0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[12]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,oracle.com];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 20F6838752
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Steve Sistare <steven.sistare@oracle.com> writes:
>
>> Define vmstate_register_named which takes the instance name as its first
>> parameter, instead of generating the name from VMStateIf of the Object.
>> This will be needed to register objects that are not Objects.  Pass the
>> new name parameter to vmstate_register_with_alias_id.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Actually, can't we define a wrapper type just for this purpose? For
example, looking at dbus-vmstate.c:

static void dbus_vmstate_class_init(ObjectClass *oc, void *data)
{
...
    VMStateIfClass *vc = VMSTATE_IF_CLASS(oc);

    vc->get_id = dbus_vmstate_get_id;
...
}

static const TypeInfo dbus_vmstate_info = {
    .name = TYPE_DBUS_VMSTATE,
    .parent = TYPE_OBJECT,
    .instance_size = sizeof(DBusVMState),
    .instance_finalize = dbus_vmstate_finalize,
    .class_init = dbus_vmstate_class_init,
    .interfaces = (InterfaceInfo[]) {
        { TYPE_USER_CREATABLE },   // without this one
        { TYPE_VMSTATE_IF },
        { }
    }
};

static void register_types(void)
{
    type_register_static(&dbus_vmstate_info);
}
type_init(register_types);

