Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3A8C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 20:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdcYA-0000MN-AG; Fri, 23 Feb 2024 15:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rdbuq-0002uO-82
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:13:04 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rdbun-0005gq-6U
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:13:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DCF4921F5A;
 Fri, 23 Feb 2024 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708719176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n74DUAWBwx3xDeSsRQwzKa9rFx6qh8ucOS9fd350eh0=;
 b=EZ+5tF7cmGztwnZOEle8w/+AMFQA7Y1F0eq0qypQNo6EN6MZJ4KGgfs+60ntEMeyFUuQbJ
 AkoeNbdvApyJWKc3OWRuDcjpA8mssS9QHi6IfwddMOmvlGXXBE6puI3577mEOxGlbJQ0Wm
 pb2265HNHOmK4lsH8JeEf5wFtHnFHPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708719176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n74DUAWBwx3xDeSsRQwzKa9rFx6qh8ucOS9fd350eh0=;
 b=Y2Q75eaVUI+O/K4Vva5fpfAYfqvwB43IDZ9/N6Q/MEIcjHjHLs0H5YjZZwkiJ1Ln7isHWI
 BBYKL7pv+a6nwhDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708719175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n74DUAWBwx3xDeSsRQwzKa9rFx6qh8ucOS9fd350eh0=;
 b=DiYXOEKd6XsEjoqOBzpVBoZhMBY6t0N2D697QufeNLxL9ELvUT7l4cWJwR22Ky9vCM+x1q
 dGcu9HqZ8iVpa4sZPCiuF3LVhxm+/LUYUGkFHPJVG9W0tGcNXQb2eABU0xUyLoWpWFAwWx
 5zHQbJEA7XPCuqYuy3AHz9cQFDshMIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708719175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n74DUAWBwx3xDeSsRQwzKa9rFx6qh8ucOS9fd350eh0=;
 b=jA86Y3H4Fgv9dGgyVdGAgzSaOdiYouWLfkJBkuPzzVwWmnERIkudYlLus/GUGsdo3FSTg9
 aawsUJv1fsBF0+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67284132C7;
 Fri, 23 Feb 2024 20:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JafOC0f82GU+YwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Feb 2024 20:12:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
In-Reply-To: <20240223152517.7834-2-het.gala@nutanix.com>
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com>
Date: Fri, 23 Feb 2024 17:12:52 -0300
Message-ID: <87zfvr7xdn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DiYXOEKd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jA86Y3H4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.79 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-0.28)[74.23%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,nutanix.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: DCF4921F5A
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

Het Gala <het.gala@nutanix.com> writes:

> Introduce support for adding a 'channels' argument to migrate_qmp_fail,
> migrate_incoming_qmp and migrate_qmp functions within the migration qtest
> framework, enabling enhanced control over migration scenarios.

Can't we just pass a channels string like you did in the original series
with migrate_postcopy_prepare?

We'd change migrate_* functions like this:

  void migrate_qmp(QTestState *who, const char *uri, const char *channels,
                   const char *fmt, ...)
  {
  ...
      g_assert(!qdict_haskey(args, "uri"));
      if (uri) {
          qdict_put_str(args, "uri", uri);
      }
  
      g_assert(!qdict_haskey(args, "channels"));
      if (channels) {
          qdict_put_str(args, "channels", channels);
      }
  }

Write the test like this:

  static void test_multifd_tcp_none_channels(void)
  {
      MigrateCommon args = {
          .listen_uri = "defer",
          .start_hook = test_migrate_precopy_tcp_multifd_start,
          .live = true,
          .connect_channels = "'channels': [ { 'channel-type': 'main',"
                              "      'addr': { 'transport': 'socket',"
                              "                'type': 'inet',"
                              "                'host': '127.0.0.1',"
                              "                'port': '0' } } ]",
          .connect_uri = NULL;
                               
      };
      test_precopy_common(&args);
  }

  static void do_test_validate_uri_channel(MigrateCommon *args)
  {
      QTestState *from, *to;
      g_autofree char *connect_uri = NULL;
  
      if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
          return;
      }
  
      wait_for_serial("src_serial");
  
      if (args->result == MIG_TEST_QMP_ERROR) {
          migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
      } else {
          migrate_qmp(from, args->connect_uri, args->connect_channels, "{}");
      }
  
      test_migrate_end(from, to, false);
  }

It's better to require test writers to pass in their own uri and channel
strings. Otherwise any new transport added will require people to modify
these conversion helpers.

Also, using the same string as the user would use in QMP helps with
development in general. One could refer to the tests to see how to
invoke the migration or experiment with the string in the tests during
development.

