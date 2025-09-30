Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B63DCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 16:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3d56-0005Qv-EK; Tue, 30 Sep 2025 12:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3d53-0005Qj-1k
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3d4x-0002Ok-9x
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759249187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2NX0PonIjVwuhjEqcKgwWnlcl5OwFsGBRzOw6iimC4=;
 b=Muo9L0aKYN/aH+coqdLWgTMR8cXlKSAOsAo13Im8KSNeY8Fv29s9gEqCiivwnFH4UpxDWP
 7LplRMduiSolXZ1XgwLQVmifJkbjwYR3YcaupVZ12Ikdo/jjH8lx/TWQ9m5+uCnyc0P5sW
 XIunE3+mTxpeRRz/jfCFajxSNTYgiLw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-HO4pOOQmOiysp86s_F3Tpw-1; Tue, 30 Sep 2025 12:19:43 -0400
X-MC-Unique: HO4pOOQmOiysp86s_F3Tpw-1
X-Mimecast-MFC-AGG-ID: HO4pOOQmOiysp86s_F3Tpw_1759249181
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-84b9c23b8aeso1410285985a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 09:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759249181; x=1759853981;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U2NX0PonIjVwuhjEqcKgwWnlcl5OwFsGBRzOw6iimC4=;
 b=f8NPN0VSsvS9s0n/vng4jzE0igh9FHbyjL2VxPqfR6Vb3BiWsgj1LnubWpfzwPmN27
 nhxsDjdXHsjjzlgicbjzsvLf3CFMkyGmgxRksgAf/5Lhg2fF0HjW5BLvDCpD7sk5FbId
 MTuwTfz/fVAh7tXcc4zGU5PporwzoE4CJbbvD/d9DlQVp/+oze44b/KGTgc5fDNbOJts
 1SIAlxGKjE9iQePmllZ+12SQBVIDX+MW65jGfmsqrHguSo4C+m8EVk2t9GvQ/SkPdfHI
 GEGe0OoTCK2wduV/T/nPgWsdyHgpG0diWBmZiygCYZeN1u0eKUR5k7jpThO6B+N8Svs9
 F6KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+aMN/BjAFIifXsFLoaO8o1aeyBztURZ0OgKcY6sVDe4x7F10eafmhXmB4dktoWzzZruW3JU8j4zLU@nongnu.org
X-Gm-Message-State: AOJu0YzE9LR1YxEF1VyLnPc74DuUwKfSk9wGrpqgru4shK3/0f8anUmF
 RzWp7tbymcorMfbIZoyUunZFHXgJK+FDDGKYZF8Ij7TQq64q7FfKiD/lfeQfgq2Jcu0F1VJaac8
 ohxREntOr4wh/96f19zrlWTkeA5jZS6J0ywkMNCKRol3p9eyryT3ILdN7
X-Gm-Gg: ASbGncuA34pHyPX/4dFgnYzKUmlpcdAXh6v1vKQVEfe3nrkoyPGTOkiSikFnZl5ibot
 Hq9iunIOltEUtqbImoiIQsJfdXg6aOsTGQm+2QSRw0HcMVbok/rNs2T8Kw59cqfEI0tlHen7WAz
 jJzXyhZwVuLKs0u20qfAepJ0mEcr1BBvB6vyrvqsJp26I8egTDxmofCmKFUOkdagBWj3x+wXD/0
 ozp/W9ZlAAKWXvLw+W4nG4kqF1Cby9y1oaoeBZb2TTQrekT1lNNrCjHBoMoDKjYx7FCGzdAFVXP
 Fsv/PLc6NgoV1m+C+ejWfwJDrv7JpawNX7DC1Q==
X-Received: by 2002:a05:620a:4542:b0:85a:7984:5f4b with SMTP id
 af79cd13be357-8737780ada5mr59033985a.73.1759249180993; 
 Tue, 30 Sep 2025 09:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlRI3+QdP7uKqZ6BG/KyjmQ0wjxCQOsdePmXZKDgeGFpkKC93gpfTagQRB0qk9Nap+E4UdAg==
X-Received: by 2002:a05:620a:4542:b0:85a:7984:5f4b with SMTP id
 af79cd13be357-8737780ada5mr59027885a.73.1759249180473; 
 Tue, 30 Sep 2025 09:19:40 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c28a8a7e0sm1076012385a.22.2025.09.30.09.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:19:39 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:19:38 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V4 5/8] migration: cpr-exec save and load
Message-ID: <aNwDGpxZMFWj-ELW@x1.local>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-6-git-send-email-steven.sistare@oracle.com>
 <15399e70-fa4b-4792-9881-9dec59f0c832@redhat.com>
 <e8766c16-5f8e-4b3d-8808-42158d28b549@oracle.com>
 <6d5b95e4-1d50-4b70-8d40-9031f3735d56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d5b95e4-1d50-4b70-8d40-9031f3735d56@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 25, 2025 at 09:11:33AM +0200, Cédric Le Goater wrote:
> > > That's a short term hack right ? it's not even documented.
> > 
> > It is an implementation detail, known only to the matched saving
> > and loading functions inside qemu.  No one else needs to know, so
> > no documentation.
> 
> ok. Fair enough.

IMHO Cedric's ask is fair.  At least when people reading the doc may get
confused of why cpr channel isn't needed for the exec mode in its API.

Could we still add one liner into the doc to describe it?  Something that
would mention a temp memfd and passing it over using environment vars would
help.

Thanks,

-- 
Peter Xu


