Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62EBC54756
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 21:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH7tA-00009Q-Ae; Mon, 19 May 2025 17:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uH7t8-000092-QT
 for qemu-devel@nongnu.org; Mon, 19 May 2025 17:19:10 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uH7t6-00057I-QX
 for qemu-devel@nongnu.org; Mon, 19 May 2025 17:19:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A14022083;
 Mon, 19 May 2025 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747689545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1WzxLYGWzDYKGwvt2++Tx9dud6RxSPD+p5MAgJEWO0=;
 b=J9NT7LPdf9V4/tcnabWRbmGsGGXr3jtx8QUVF7juV/PnilYiu2pLt05fVQV36upYGTkDbf
 hwETkjBredM8rINx9OoUR0mOKqY08pPBYuOUQrZ2JzzxkmdVLwqx76eRz3hBnKJl1DSb2q
 ahSzDWf+FJp9DAvcjgcUthTPNkrLVpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747689545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1WzxLYGWzDYKGwvt2++Tx9dud6RxSPD+p5MAgJEWO0=;
 b=6AyCmeNIosxFmBXw66XOqo14GgURbsk2t9yPki2kUIuj5Ry6aH8aYa9mlYEKTCB7fv0+7q
 K/MYhep9q/4+tBCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747689544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1WzxLYGWzDYKGwvt2++Tx9dud6RxSPD+p5MAgJEWO0=;
 b=xsjy7mOR0IYe+r/Ft4+4qSBV4YzOkFhibD95f1HU61hodSXJAIICKIc597UNgbUvv8Y7lb
 Ix6RPBTl6vksscClBW5dYzXfH8qUHfbb5s05CysbNL/1JW4O0mESt5FwSXuW8n2rmuUWql
 /j0PJ5rmbxaffJ9JDL9SugS2Qvc3gyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747689544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1WzxLYGWzDYKGwvt2++Tx9dud6RxSPD+p5MAgJEWO0=;
 b=Uy8QGdrHSIp7HrMxIjWH8McRMiEygW/eX0SvUrfkGBObOikI1+iqC3E4RoKRdjFEEjiLkz
 VfJSjUvmyArbxrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DBD513A30;
 Mon, 19 May 2025 21:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hPVtE0egK2jtJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 19 May 2025 21:19:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>, Steve
 Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 0/5] fast qom tree get
In-Reply-To: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
Date: Mon, 19 May 2025 18:19:00 -0300
Message-ID: <878qms70zf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.30 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid, qom.py:url,
 oracle.com:email]
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Using qom-list and qom-get to get all the nodes and property values in a
> QOM tree can take multiple seconds because it requires 1000's of individual
> QOM requests.  Some managers fetch the entire tree or a large subset
> of it when starting a new VM, and this cost is a substantial fraction of
> start up time.
>
> To reduce this cost, consider QAPI calls that fetch more information in
> each call:
>   * qom-list-get: given a path, return a list of properties and values.
>   * qom-list-getv: given a list of paths, return a list of properties and
>     values for each path.
>   * qom-tree-get: given a path, return all descendant nodes rooted at that
>     path, with properties and values for each.
>
> In all cases, a returned property is represented by ObjectPropertyValue,
> with fields name, type, and value.  If an error occurs when reading a value
> the value field is omitted.  Thus an error for one property will not cause a
> bulk fetch operation to fail.
>
> To evaluate each method, I modified scripts/qmp/qom-tree to use the method,
> verified all methods produce the same output, and timed each using:
>
>   qemu-system-x86_64 -display none \
>     -chardev socket,id=monitor0,path=/tmp/vm1.sock,server=on,wait=off \
>     -mon monitor0,mode=control &
>
>   time qom-tree -s /tmp/vm1.sock > /dev/null
>
> I only measured once per method, but the variation is low after a warm up run.
> The 'real - user - sys' column is a proxy for QEMU CPU time.
>
> method               real(s)   user(s)   sys(s)  (real - user - sys)(s)
> qom-list / qom-get   2.048     0.932     0.057   1.059
> qom-list-get         0.402     0.230     0.029   0.143
> qom-list-getv        0.200     0.132     0.015   0.053
> qom-tree-get         0.143     0.123     0.012   0.008
>
> qom-tree-get is the clear winner, reducing elapsed time by a factor of 14X,
> and reducing QEMU CPU time by 132X.
>
> qom-list-getv is slower when fetching the entire tree, but can beat
> qom-tree-get when only a subset of the tree needs to be fetched (not shown).
> qom-list-get is shown for comparison only, and is not included in this series.
>
> Changes in V2:
>   * removed "qom: qom_resolve_path", which was pulled separately
>   * dropped the error member
>   * fixed missing _list_tree in qom.py
>   * updated 10.0 to 10.1
>
> Steve Sistare (5):
>   qom: qom-tree-get
>   python: use qom-tree-get
>   tests/qtest/qom-test: unit test for qom-tree-get
>   qom: qom-list-getv
>   tests/qtest/qom-test: unit test for qom-list-getv
>
>  python/qemu/utils/qom.py        |  36 ++++++-------
>  python/qemu/utils/qom_common.py |  48 +++++++++++++++++
>  qapi/qom.json                   |  90 ++++++++++++++++++++++++++++++++
>  qom/qom-qmp-cmds.c              | 112 +++++++++++++++++++++++++++++++++++++++
>  tests/qtest/qom-test.c          | 113 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 381 insertions(+), 18 deletions(-)
>
> base-commit: 7be29f2f1a3f5b037d27eedbd5df9f441e8c8c16

Acked-by: Fabiano Rosas <farosas@suse.de>

