Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF823E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 13:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVVzG-0003kS-MW; Wed, 08 Jan 2025 08:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVVzF-0003ix-0s
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:20:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVVzD-0000ZL-4c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736342436;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuZEqFhsal7VwunRpOxL6puIgmNG8jk3VozxGUxkQOk=;
 b=gU7XiLgDVdBI19Sao14jEYlGHxrsm6Zrc2yTIcXGvHUmYrA5HXPFvEqB2LLrjJK1d29COx
 2GbpBGxwXW7wbgH2Y2LugBrYJTvHc+DSTpmL0C1jP1pQRWwdH3ru9IfMW1Z6cU8gUwQ8HX
 Kxdug6VOJh5JjLkOUJ/kJxqfX8NM4FQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-_qZgtaJIM0C139fgf5HcbQ-1; Wed,
 08 Jan 2025 08:20:33 -0500
X-MC-Unique: _qZgtaJIM0C139fgf5HcbQ-1
X-Mimecast-MFC-AGG-ID: _qZgtaJIM0C139fgf5HcbQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 646681956064; Wed,  8 Jan 2025 13:20:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.103])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0EF519560AB; Wed,  8 Jan 2025 13:20:28 +0000 (UTC)
Date: Wed, 8 Jan 2025 13:20:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Message-ID: <Z357mUof2tOvS8gQ@redhat.com>
References: <20250108125751.199929-1-anisinha@redhat.com>
 <Z354ytFhuJnohBXx@redhat.com>
 <591DC037-7D47-4DE0-B83E-E1A1BC452175@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <591DC037-7D47-4DE0-B83E-E1A1BC452175@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 08, 2025 at 06:47:25PM +0530, Ani Sinha wrote:
> 
> 
> > On 8 Jan 2025, at 6:38 PM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > On Wed, Jan 08, 2025 at 06:27:50PM +0530, Ani Sinha wrote:
> >> At present, the libqos/fw_cfg.c library does not support the modern DMA
> >> interface which is required to write to the fw_cfg files. It only uses the IO
> >> interface. Implement read and write methods based on DMA. This will enable
> >> developers to write tests that writes to the fw_cfg file(s). The structure of
> >> the code is taken from edk2 fw_cfg implementation. It has been tested by
> >> writing a qtest that writes to a fw_cfg file. This test will be part of a
> >> future patch series.
> >> 
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> ---
> >> tests/qtest/libqos/fw_cfg.c | 204 ++++++++++++++++++++++++++++++++----
> >> tests/qtest/libqos/fw_cfg.h |   5 +
> >> 2 files changed, 186 insertions(+), 23 deletions(-)
> > 
> >> +static bool
> >> +find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
> >> +                uint16_t *sel, uint32_t *size)
> >> +{
> >> +    unsigned char *filesbuf = NULL;
> > 
> > Use g_autofree here instead of later g_free.
> 
> OK will send just a refactoring patch with this change.
> 
> > 
> >> +    uint32_t count;
> >> +    size_t dsize;
> >> +    FWCfgFile *pdir_entry;
> >> +    uint32_t i;
> >> +    bool found = false;
> >> +
> >> +    *size = 0;
> >> +    *sel = 0;
> >> +
> >> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> >> +    count = be32_to_cpu(count);
> >> +    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
> >> +    filesbuf = g_malloc(dsize);
> >> +    g_assert(filesbuf);
> >> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> >> +    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
> > 
> > I'm not familiar with fwcfg data format, but I'm wondering
> > what the initial 'uint32_t' data field is that you're skipping
> > over, and whether its value should be validated before this
> > loop ?
> 
> This part I left as is from previous code. From https://www.qemu.org/docs/master/specs/fw_cfg.html
> 
> struct FWCfgFiles {         /* the entire file directory fw_cfg item */
>      uint32_t count;        /* number of entries, in big-endian format */
>      struct FWCfgFile f[]; /* array of file entries, see below */
> };
> 
> struct FWCfgFile {       /* an individual file entry, 64 bytes total */
>     uint32_t size;       /* size of referenced fw_cfg item, big-endian */
>     uint16_t select;     /* selector key of fw_cfg item, big-endian */
>     uint16_t reserved;
>     char name[56];       /* fw_cfg item name, NUL-terminated ascii */
> };
> 
> So the code first reads the count and then allocates ‘count' entries for ‘count' files.

Ah right, so the first qfw_cfg_get already read count,
and the second qfw_cfg_get reads it again, followed by
the entries, so we can ignore that first field.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


