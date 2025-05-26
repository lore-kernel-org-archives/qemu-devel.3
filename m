Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF17C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 15:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJZTY-0003KF-RT; Mon, 26 May 2025 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJZTU-0003Js-M0
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJZTR-00046c-JD
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748272241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMoXzdk/bV1Xq2sRiFQfcZoBE7LZ5GQVprIfU6IBEYQ=;
 b=YJRbbomu/jIhacO3wIceHGSP6rpmeu0l1sFVFW9iC7tWvisHmKE5XGGAhw4YFJiOfKkpfV
 ATmNM2z5xwtJuOJetUZYEvrJdXT2qsH+XscXYFRmWmFKOD3Wf3jYhVUdCOmhjbp8P3krgH
 s76kwXipZzTmw+T4UhjZdWRoJO7+Mug=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-6Da3wGnLO9OBCVtOEsclug-1; Mon, 26 May 2025 11:10:40 -0400
X-MC-Unique: 6Da3wGnLO9OBCVtOEsclug-1
X-Mimecast-MFC-AGG-ID: 6Da3wGnLO9OBCVtOEsclug_1748272240
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c54e7922a1so560556285a.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 08:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748272240; x=1748877040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMoXzdk/bV1Xq2sRiFQfcZoBE7LZ5GQVprIfU6IBEYQ=;
 b=TdDzYa0td8fqw84Idb1VFB7+LyNepvO2/OQRKkiSUVcZ6t+XEUH8nLwpk9FYthmACn
 oRyzD0n8IEXfOOm61NfVDAi8fkYPELQQVztCz/jCe7t81CdP2RJp4g1gWNA3fuauhrIE
 jRVFBpPX68aHzu261DfxvUHp5xHcq1AgJ2wLQNzV9PwRlTKliiZtYSWjJobnIoSeePpJ
 LG18w3tmLhM7UTK4NLM5b1Ll3EJIKEgT2plunveJDl4fzqoz4GGy+f/78uCVhNnytl6g
 wOoDc6cC33gUxWaiVe4pHcMaVNYZrFiqpjI/lOZwDsxizF0c8Do16AbLh9auxwfZp5ub
 O1EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX26JmUYC6hdmEtYW7S2agtahMdG4vheJYFk60+d22nyosK42NO/iqk9IFS78ncld/Q009Maskox3h@nongnu.org
X-Gm-Message-State: AOJu0YxntfWoIGuPLiC/8dvvOagHKv+HTtFoeVeZzZhtiwXgUoUTmfTj
 /pDf2Lt+mQna+V5p7E/OiN8t0HEIC2doo5YpZFpPQ2co4hHG6IDMumMvWAjYy5McnRZF0pktMwO
 bfT2I0ITg/pYUtLM8LP8+nxOShLCKYVYV7ca43SDlKT5lgy8dOCgZ6mcQ
X-Gm-Gg: ASbGnctWI0Kxj5ZKIZqRIaKPwzLQ+EtFUN51MzjmmF0KosADYdpMqOC3vbsCdSCqW3P
 RQV7iTe2zEasA6diIaLIyGorplwCtjPHMOvHr1kRzdpdog0KwckoABiOl17qwM43wCasymmEJY6
 mGSOCFOV3qlA25dj1k5JhRH441P3iXySOvhbvfBQSV4N7neuT9s67iVQ382wLNnbSgxFoVfr8c4
 RD8eNePc44HRsbGVXdAiI+Z1lnISonxkx94ZoGiVZsTz8K2U/DYWODF+i/I66tPKNbj5XF6JPbJ
 vAE=
X-Received: by 2002:a05:620a:6013:b0:7c5:674c:eecc with SMTP id
 af79cd13be357-7ceecbe8957mr1372711285a.32.1748272239733; 
 Mon, 26 May 2025 08:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDBoseGIkivgy+uYJpPiWHbycqciZgnPUziM93QnOU6vkOIMha/4g8TXlm4seIEyXWfJ0UGg==
X-Received: by 2002:a05:620a:6013:b0:7c5:674c:eecc with SMTP id
 af79cd13be357-7ceecbe8957mr1372707185a.32.1748272239317; 
 Mon, 26 May 2025 08:10:39 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd468b879csm1574239585a.70.2025.05.26.08.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 08:10:38 -0700 (PDT)
Date: Mon, 26 May 2025 11:10:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 13/13] [PoC] migration: Allow migrate commands to
 provide the migration config
Message-ID: <aDSEa8eh1txwwun6@x1.local>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-14-farosas@suse.de>
 <87tt57ajdg.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tt57ajdg.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 26, 2025 at 10:03:55AM +0200, Markus Armbruster wrote:
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index bb2487dbc6..5bd8f0f1b2 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1638,6 +1638,10 @@
>    ##
>    # @migrate:
>    #
>    # Migrates the current running guest to another Virtual Machine.
>    #
>    # @uri: the Uniform Resource Identifier of the destination VM
>    #
>    # @channels: list of migration stream channels with each stream in the
>    #     list connected to a destination interface endpoint.
>    #
>    # @detach: this argument exists only for compatibility reasons and is
>    #     ignored by QEMU
> >  #
> >  # @resume: resume one paused migration, default "off".  (since 3.0)
> 
> Unrelated to this patch, but here goes anyway.  What happens if I pass
> @uri and @channels with I "resume": true, and they differ from the ones
> passed originally?

I can answer this one - "resume" was designed to work always with new
channels/URI passed in.  It was currently only used for postcopy to resume
a paused postcopy migration where the old URI/channels stopped working
already.

The doc is indeed not obvious to show that, and can be confusing.  If
anyone thinks worthwhile, I can send a patch to touch it up:

diff --git a/qapi/migration.json b/qapi/migration.json
index 8b9c53595c..a4c9272e8b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1658,7 +1658,10 @@
 # @detach: this argument exists only for compatibility reasons and is
 #     ignored by QEMU
 #
-# @resume: resume one paused migration, default "off".  (since 3.0)
+# @resume: when set, resume one paused postcopy migration, using the new
+#     URI/channels specified to replace the old/broken channels.  The user
+#     should make sure the migration is in "postcopy-paused" state before
+#     the resume request.  Default "off".  (since 3.0)
 #
 # Since: 0.14
 #

Thanks,

-- 
Peter Xu


