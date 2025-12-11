Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90C2D43358
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 21:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTnzO-0005BZ-1J; Thu, 11 Dec 2025 16:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTnzM-0005B4-5q
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 16:14:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTnzK-0003qt-Iw
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 16:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765487652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VySSaqDQusUMaMJdYc41Pn/gKsB8JcxLBpE69ghBze4=;
 b=DXw5b4zUwryE5VWGU7u7rHV8O3CKiliws+ccQnXhp+TFO/q45CIaseE5xGQ9MmjCmL/4B8
 HsykNCGT8dWVcfcmt+reKy10Pp8XQE+BfCZSJ/xmC/XcJWFlLKFhJFhlEHBhWld4nWeXM8
 FJujQ3/cOEp2a+SfhYEHaSuDj7PaOVo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-zcFNjRYkOe2lW6EfQRGGTw-1; Thu, 11 Dec 2025 16:14:11 -0500
X-MC-Unique: zcFNjRYkOe2lW6EfQRGGTw-1
X-Mimecast-MFC-AGG-ID: zcFNjRYkOe2lW6EfQRGGTw_1765487650
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8bb0ae16a63so70457185a.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 13:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765487650; x=1766092450; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VySSaqDQusUMaMJdYc41Pn/gKsB8JcxLBpE69ghBze4=;
 b=X/DwLX+mbSVZ45cKsaMKdsGxquOJxOaCLxN+tgNQMarPM4DcXHuI5b3/WAJcxJJ2l5
 1F3Zwha7BBCi5h4tXBFP7TTVHrjX9sRVnswBxTJNf+mbaywPlXzxc/uJadezIgCagGLP
 sLbiMpsluReGajzzsNhYFPbI/bEu6vw7FvzR1oA4RMp/7XETOHeKB2PVfCp8EijIds9G
 XwkRHrLLsBc0+u+6nGTLTAsgH/yNjLsG8h41ANHg1hR37LwHosNzZ5CxKWvuxSAtFHtZ
 YLOCv2dRV1iAuqwF8NuJvFxhzYwHYe4mdKtERyMcpuwaWU6zt+pVlhYnOkvv7Ve+3TbU
 rFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765487650; x=1766092450;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VySSaqDQusUMaMJdYc41Pn/gKsB8JcxLBpE69ghBze4=;
 b=vxhyrXR/JRzFKt+zKNQLcejQA1fB+cMKY+jbo38oXII1Po356bjGaX3ocb/NIF5yQd
 1pFy5nrehR+rttuvzWa+TQQZKOtkDFnP5TpEIPgRRn+KI5wTf3G/IvpPOGoplOntU3hI
 J7IGo1DpGIhGB+VIdjLTHoy02Avw3XNsUNX0R5Imkg3FLuKwaH0kQpimlXd8aIlr7d0R
 s/MmksGfkn3jMZvIfxSgtPL7c8A0Nq6ghyDhdvuBDvTpUaokmIs2N6j2swyoOfBbTxFV
 ynLOnGv71/cZVGJluj+z4Rant0mfu3jQjvWcOXpl/Qr+YpTkiX1BMhie/IdyYdY0SmOy
 zQ5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjU4A0YTVSfC41v9JIyp7HfzllSDL6826r9VuBZXSXfvyIJooF58rLXgTB+K4N9GU5Daqx6vo5T28r@nongnu.org
X-Gm-Message-State: AOJu0YyrIFXEMAbVHYYCLpr9u7zNZrdbHyAdf05ibDjW2z8FN3FFMkDj
 l0qqRDemsSGBha0ePZwmB75dm4DcEKBYtrbOrrIH95/vk9Md3fn/WvAyqbR+97wjOFq/tHHW3Kv
 +8wuZsdUxo+j8GNLip54iEhBVa1dS6cwichP28pVL9IK6GIgBdi37Qg7t
X-Gm-Gg: AY/fxX4CiXMXnqk0VNVF4AohgezfAaSepeBR/x4DQExTaoyzG9HGLnmD0ZPQeOL6MQA
 g7ci1yRG7KH/0JC8094Nvd718NsK82JEyS9/jsI6BtmnvdqUb8S4Wo1W+GBE944zUAWrE1wq5uu
 ILQTQ8uV2hI/xvA6LVmz4H38GGC4A3rgSPiIrJSUvj6ZYE+UBpQyp6cu2yR2zLR3sQT+2kxlQ2T
 2d3+bmBJCFJWnL69LSqj0K2F0r15j6QnI0snHJQ14VqgaJG+siWrRctW/i9JeTY5RVAxiYbq5m6
 CJsm9fJHwR8S/lB4PO4K7qT6vcvHR8feEuk170uI+pfMM63c1GChdQBL0hfehdWleRDaUrKEd35
 xud8=
X-Received: by 2002:a05:620a:199f:b0:8b2:f9ac:a885 with SMTP id
 af79cd13be357-8ba3ae34c5dmr1099392185a.71.1765487650376; 
 Thu, 11 Dec 2025 13:14:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQWjBybuJAKBxfTWhilqr26e476MJZympUF/MfJy+CIobaRhAQ0/W5IzE4Vso6jHmMUGOSVQ==
X-Received: by 2002:a05:620a:199f:b0:8b2:f9ac:a885 with SMTP id
 af79cd13be357-8ba3ae34c5dmr1099387985a.71.1765487649844; 
 Thu, 11 Dec 2025 13:14:09 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab5c3c85bsm318251585a.26.2025.12.11.13.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 13:14:09 -0800 (PST)
Date: Thu, 11 Dec 2025 16:14:08 -0500
From: Peter Xu <peterx@redhat.com>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mark.kanda@oracle.com" <mark.kanda@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Hudson, Nick" <nhudson@akamai.com>
Subject: Re: [PATCH] migration: cpr socket permissions fix
Message-ID: <aTs0IH6Ld3HE80iM@x1.local>
References: <20251120185733.141912-1-bchaney@akamai.com>
 <aSCOVNMJ-NK_9PuH@x1.local>
 <3DD5C44B-B1D5-4E5D-95F5-45DA855DDD39@akamai.com>
 <aTL2j7PB4--w68ir@x1.local>
 <85437E51-DEC6-4B79-8E5E-93B5D64D4CB2@akamai.com>
 <aThwdthSF30NygY4@x1.local>
 <3DC0D610-FDC3-47CC-83F0-BC9CD470E972@akamai.com>
 <aTsXtmUVP1TfRZaS@x1.local>
 <C8ABA8F2-C459-4911-8DAA-C5FC6489EEB2@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C8ABA8F2-C459-4911-8DAA-C5FC6489EEB2@akamai.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 11, 2025 at 08:44:27PM +0000, Chaney, Ben wrote:
> 
> 
> ﻿> On 12/11/25, 2:13 PM, "Peter Xu" <peterx@redhat.com <mailto:peterx@redhat.com>> wrote:
> 
> > On Thu, Dec 11, 2025 at 06:42:05PM +0000, Chaney, Ben wrote:
> > >
> > >
> > > On 12/9/25, 1:55 PM, "Peter Xu" <peterx@redhat.com <mailto:peterx@redhat.com> <mailto:peterx@redhat.com <mailto:peterx@redhat.com>>> wrote:
> > > >
> > > > On Mon, Dec 08, 2025 at 07:32:41PM +0000, Chaney, Ben wrote:
> > > >
> > > > > On 12/5/25, 10:13 AM, "Peter Xu" <peterx@redhat.com <mailto:peterx@redhat.com> <mailto:peterx@redhat.com <mailto:peterx@redhat.com>> <mailto:peterx@redhat.com <mailto:peterx@redhat.com> <mailto:peterx@redhat.com <mailto:peterx@redhat.com>>>> wrote:
> > > > >
> > > > >
> > > > > > Maybe you can stick with -incoming defer, then it'll be after step [3],
> > > > > > which will inherit the modified uid, and mgmt doesn't need to bother
> > > > > > monitoring.
> > > > >
> > > > > I tried this approach, but It doesn't look like it is possible to create the
> > > > > cprsocket later with -incoming defer.
> > > >
> > > >
> > > > You'll still need to chmod for the cpr socket. "defer" will still help the
> > > > main channel to be created with the uid provided.
> > >
> > > Thanks for the pointers. I was able to get the incoming defer method
> > > working, but it has much worse performance than the other method.
> > >
> > > Would you be open to a solution where we chown only the migration
> > > sockets, or would that run into similar concerns?
> >
> >
> > We can evaluate, but before that, could you explain your current solution
> > first?
> >
> >
> > And, what is the performance you mentioned here that is worse?
> >
> >
> > I at least didn't expect it to be downtime, because IIUC what your mgmt
> > needs to do is to chmod on the cpr channel first (during which migration
> > hasn't started), then chmod once more on the main channel after CPR channel
> > migrated and before main channel migration happens (during which VM should
> > be running on src), hence it should have nothing to do with downtime.
> 
> I wouldn't have expected this to affect downtime either, but it does increase the
> downtime by about 3.5 seconds (700-800ms to just over 4s). I am using the
> following setup to defer the creation of the main socket:
> 
> qemu-system-x86_64 ... -incoming defer -incoming \
> '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "cpr.sock"}}'
> 
> chown $UID:$GID cpr.sock
> 
>         echo '{"execute":"qmp_capabilities"}
> {"execute": "query-status"}
> {"execute":"migrate-set-parameters",
>    "arguments":{"mode":"cpr-transfer"}}
> {"execute": "migrate", "arguments": { "channels": [
>     {"channel-type": "main", "addr": { "transport": "socket", "type": "unix",
>                "path": "main.sock"}},
> {"channel-type": "cpr",
>      "addr": { "transport": "socket", "type": "unix",
>                "path": "cpr.sock"}}]}}
> 
> {"execute": "query-status"}
> 
> {"execute": "query-migrate"}
> ' | $SSH_COMMAND socat STDIO unix-connect:qemu_src.monitor
> 
> echo '{"execute":"qmp_capabilities"}
> {"execute": "migrate-incoming", "arguments": { "channels": [
>     {"channel-type": "main", "addr": { "transport": "socket", "type": "unix",
>                "path": "main.sock"}}]}}
> {"execute": "query-status"}
> {"execute": "query-migrate"}
> ' | $SSH_COMMAND socat STDIO unix-connect:qemu_dst.monitor
> 
> The migration finishes as soon as the migrate-incoming command is issued.

This really sounds weird, because this window should be the maximum
downtime..  if it finished so fast, something is wrong.

Could you spend some time investigate this problem?  IMHO something was
very off, a few seconds of downtime shouldn't be hard to chase.

If we need to justify a chmod on top of migration channels, we still need
to know why it's needed.

Thanks,

> There is no opportunity to chown the main socket, but because it is being
> hot plugged it gets created with the appropriate permissions.
> 
> I should also note that I am testing this in combination with the patch set for
>  cpr transfer for tap devices, which makes the issue more pronounced in terms
> of network interruption, however the reported downtime increases by 3.5s
> regardless of if that patch set is applied or not.

-- 
Peter Xu


