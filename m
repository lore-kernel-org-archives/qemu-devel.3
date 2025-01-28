Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD97BC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 05:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tceBH-0001DF-OU; Tue, 28 Jan 2025 00:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tceBG-0001Cn-Fa
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 00:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tceBE-0001gC-OF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 00:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738042230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R7QIOZWc4riGdOEeltugd053q1rBEuvcEhZArvkKTeA=;
 b=Ihu2astOtBnsSlSfyVZFGSDT37mu3kK9BKUh5ipgodBP1icGV8EC+aVzUVcI1d5q0f5Wgy
 iqTHhlcYlcsUlVRfWtE1WZ49m+FrXLsS7oDClP0F5Dk6d8f2vT4c+UHaVMBooWeAnrA9UO
 WaVToXxEUvEipwjPSfro78t0hRJcCKM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-QbOLQMbjPyiUnnxzKLzzLA-1; Tue, 28 Jan 2025 00:30:27 -0500
X-MC-Unique: QbOLQMbjPyiUnnxzKLzzLA-1
X-Mimecast-MFC-AGG-ID: QbOLQMbjPyiUnnxzKLzzLA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361c040ba8so29513135e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 21:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738042226; x=1738647026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7QIOZWc4riGdOEeltugd053q1rBEuvcEhZArvkKTeA=;
 b=Fdu8R5Cn0YyUCYwRFO06LQgbFeH/txKhGzwhYap0SEElWSLUr0U/q6wExf1q8a6mXc
 VJPBh8Zin6omOcZ01SknSjlnC+29MuBS/kVB8m499wCd3dJmOJC2lHRAGiKbbVdWO4DP
 P53k+jXELohh88bvyOUhraD5JaMGOmFjuU0OSRSOa0u2+ql1Z+W67Hqsr4ov8PwAz0J6
 BTLAMZE7qqPnRE4ZTMHHbyCZi+T4yi+8sy2VfFGehBqQnFgR2kDWKMwHcZ+VtT+2RaXw
 YmvwgRnuVK+LfAszcWKqjCXrxQa3Qd4GscbiTT1EPIkCcUo6lNldUjvMVdztWgzevvvI
 aqtg==
X-Gm-Message-State: AOJu0Yw3Ec8HnD3iam3wmV/rHgXXApBBYl2RGrbrN61AceJbFHFkTcQl
 3NMc94Q0SrCBxErWQvlMtt0/RZhyWhrzOUTjzOL9heF29EBjFzkqYLRPieBAFN4Khhar4ZerVCD
 BWHmR+jy/zqbgRoOyZGzGrp+tbmu48aAuZ+t2gmgGRU3gKuGtcJzpcnsuowtmrYS8mSCFNhibbJ
 fn1p+5qGBr0j8/vwikUiQR5JVmUjI=
X-Gm-Gg: ASbGncuLpnOFzWia4WAQfzJYOmXAmxLkeWf++7bOrdfoIYybTKY/2RmsODeI4qn2K4v
 LwM4+OMbZDYl3Wvf+dO/UjNxUJ8+50iVD7SoGg2ksCcHndAjuId45j3Zd9+WAosA=
X-Received: by 2002:a05:600c:83c3:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-43891433ff6mr382241255e9.23.1738042226369; 
 Mon, 27 Jan 2025 21:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEad/8BY3x/QlL3aPcyyAVraJF0zb2w+A+8pOF4TJkIZ926n1s4aVXwCSQq+yV4v/RLu7xpqtonsdbuDwe8us0=
X-Received: by 2002:a05:600c:83c3:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-43891433ff6mr382241115e9.23.1738042226026; Mon, 27 Jan 2025
 21:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20250127120823.144949-1-ppandit@redhat.com>
 <20250127120823.144949-5-ppandit@redhat.com>
 <874j1kufin.fsf@suse.de>
In-Reply-To: <874j1kufin.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 28 Jan 2025 11:00:09 +0530
X-Gm-Features: AWEUYZmy4cPNf5eG3BQWL5KQUZWpXWwTWTf3A9rpbb3gXmQzFz7AUUIfcwGjesk
Message-ID: <CAE8KmOyj0DvODhRVoyaqGaTSe+YDV8ymieFwCgnFZM0rWRuK-w@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] tests/qtest/migration: add postcopy tests with
 multifd
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello Fabiano,

On Tue, 28 Jan 2025 at 02:43, Fabiano Rosas <farosas@suse.de> wrote:
> > +    if (args->multifd) {
> > +        migrate_set_capability(from, "multifd", true);
> > +        migrate_set_capability(to, "multifd", true);
>
> This is slightly backwards because currently that's what the hooks are
> for. I don't see the need for separate flags for multifd and
> postcopy. This also makes the code less maintainable because it creates
> two different ways of doing the same thing (hooks vs. args).

* I did look at the hook functions. In 'postcopy-tests.c' hook
function is not used. Fields are set in the 'MigrateCommon args'
object, which gets passed to migrate_postcopy_prepare() to
enable/disable capability.

* If we look at precopy-tests.c/tls-tests.c/compression-tests.c, the
same hook function 'migrate_hook_start_precopy_tcp_multifd_common'
gets called from them. Setting a capability therein shall affect all
tests which call that function. Defining a new hook function to set a
single field/capability and then calling the existing common hook
function for other attributes is doable, but doing so for multiple
qtests would only increase the number of hook functions, creating
clutter and confusion over time. (thinking aloud)

> Alternatively, we could add a more generic args->caps and have every test set the capabilities it wants and
> the _common code to iterate over those and set them to true. Something
> like this perhaps:
>
>     for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
>         if (args->caps[i]) {
>             migrate_set_capability(from, MigrationCapability_str(args->caps[i]), true);
>             migrate_set_capability(to, MigrationCapability_str(args->caps[i]), true);
>         }
>     }
>
> We could also set the number of channels as a default value. The tests
> could overwrite it from the hook if needed.

* Yes, this seems like a better option, I'll give it a try.  But
should we include it in this patch series OR make it a separate one?
I'm leaning towards the latter, because it is a generic change
affecting all tests, it's not specific to this series.

Thank you.
---
  - Prasad


