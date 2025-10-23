Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67A4CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 18:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC097-0006kV-Us; Thu, 23 Oct 2025 14:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC08x-0006hh-2F
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC08o-0008NN-SG
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761244459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vx2HDZNtLxUMfZCBDty82P24MN4iwcy/ajPXvNtcWx4=;
 b=BV9DRSVBM9XKLW96ptlvuo5cSIGD6q5oGiiD6oyLPkP2BFe9nqz9BzclDCR166IhkygVZ/
 Q7wnEfUMjdXtWH1AXRBXn3BRQpd1PBeWlJGrN1AZDnsZ6w2a6xAEpetu2yor/cBX0Uz4kS
 M4UKCbv0mwFVseYyvO1bIzv9wsCulbQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-SsGDvoM3NiKe__Q3NWvc_w-1; Thu, 23 Oct 2025 14:34:15 -0400
X-MC-Unique: SsGDvoM3NiKe__Q3NWvc_w-1
X-Mimecast-MFC-AGG-ID: SsGDvoM3NiKe__Q3NWvc_w_1761244455
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-87c2085ff29so30760936d6.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761244455; x=1761849255;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vx2HDZNtLxUMfZCBDty82P24MN4iwcy/ajPXvNtcWx4=;
 b=OFzmtJ3ItHu6tEX/A4yoMVJXgdpQvIY/rYjXjEj578PfHhuzod2pFq/cgA8GvFGN3z
 lXbQ+KawMfvvCJiR9sBmMC6lSvvj0pQ3zLeXd/WdOM4VblMLAuKWpw2ymWUz5PgaABnd
 Ssd8DUHNlF5impRr6lBR+CqcthPfxx97pEuUTunqtmQgGMHOcPz0vDyiDYn9KT185Bqy
 RLqAHh6jSkKnwjPn8K8PUnhCq9KbzFoqj88dQ6Naj8pkiTk/RyVXXuFs/rbbJ2/Kq5Ep
 D8fpmURuNT0yYmN4iEXc7kkGdLyeoeYouQeH0BfyHpjVwGWxc0vxJYjuAZl0l7K/2Tmx
 JsfA==
X-Gm-Message-State: AOJu0Yz3uG9qO1PDN2z1yM4J/OFiwjDvPAbSD150B79AI9LLE6voVLtD
 A9c49eWtPP+puITSHdgH/SbAR007222AyZa5Pwt1xPIaFnM0pLr9V/JiZLiRG36VnJdjH6r20wz
 AMCySWUXTJyn9VvBwXrVDRdeHYWYFeZxEbydo33N+HHYRVK2xg2gPxTK4
X-Gm-Gg: ASbGncsT5edweUdFhs+a9rFVK/5kVNE5seNPpEK8LkaSGtZyKfkV+O/g9zM8iwon6LV
 VL2mAvHomgwaR7Yfe77IXwVL+pjnMw+3vW8Aky0sloLoz8aPPWEtmPNdMg7IhaDGF4aO3+hzqAr
 Btq+v5h9Fy9NFhjhpDcabItVVXhJ17t6R3hsdPGtkKnzW++4h8+37cBtbAeaQrfyfdcHKT5cUrs
 E4zMbOUyASy0PWl/pbYqzUYROrxtM5fgvEiwnkOsnzZeNjMKWSfH+xpGrBi7bzmx2AZEoEn1xpo
 ymbPmCqUdjZl6AOsZwn0p8Pfah82ctY6VoWwFsQYLhzEiGtG99fgqbgWLWoWw0lqxxA=
X-Received: by 2002:a05:622a:1341:b0:4e8:b980:4792 with SMTP id
 d75a77b69052e-4e8b9804bbdmr206932861cf.37.1761244455176; 
 Thu, 23 Oct 2025 11:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF30cbO0GOkDg/Yz7xFTV1hItlJGB/tYGJSHOqvXpMApN3cCW37llsD73Y8WG6xnhI4i+1+nQ==
X-Received: by 2002:a05:622a:1341:b0:4e8:b980:4792 with SMTP id
 d75a77b69052e-4e8b9804bbdmr206932451cf.37.1761244454665; 
 Thu, 23 Oct 2025 11:34:14 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eb80804d81sm18966571cf.19.2025.10.23.11.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 11:34:13 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:34:11 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration/cpr: Document obscure usage of g_autofree when
 parse str
Message-ID: <aPp1IwqiGpBUToWg@x1.local>
References: <20251023161657.2821652-1-peterx@redhat.com>
 <aPppA7F1WamLCFdP@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPppA7F1WamLCFdP@gallifrey>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 23, 2025 at 05:42:27PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > HMP parsing of cpr_exec_command contains an obscure usage of g_autofree.
> > Provide a document for it to be clear that it's intentional, rather than
> > memory leaked.
> > 
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration-hmp-cmds.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> > index 847d18faaa..79426bf5d7 100644
> > --- a/migration/migration-hmp-cmds.c
> > +++ b/migration/migration-hmp-cmds.c
> > @@ -734,6 +734,12 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
> >          visit_type_bool(v, param, &p->direct_io, &err);
> >          break;
> >      case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
> > +        /*
> > +         * NOTE: g_autofree will only auto g_free() the strv array when
> > +         * needed, it will not free the strings within the array. It's
> > +         * intentional: when strv is set, the ownership of the strings will
> > +         * always be passed to p->cpr_exec_command via QAPI_LIST_APPEND().
> > +         */
> 
> Eww that's a bit weird isn't it.
> It's not clear to me if g_shell_parse_argv() might return an error part
> way through its parsing, and if it does whether there may be valid entries in
> strv which really do need freeing.
> 
> https://docs.gtk.org/glib/func.shell_parse_argv.html doesn't seem to say.

I checked glib code, it should be fine, the code looks like this since 2000:

gboolean
g_shell_parse_argv (const gchar *command_line,
                    gint        *argcp,
                    gchar     ***argvp,
                    GError     **error)
{
  ...
 failed:

  g_assert (error == NULL || *error != NULL);
  g_strfreev (argv);                            <-------------
  g_slist_free_full (tokens, g_free);
  
  return FALSE;
}

The hope is with the comment, the current way is still the most efficient,
avoiding strdup()s.

Still, let me know if any of us still prefer changing the code instead of
adding the comment..  The perf isn't a major issue, afaiu.  But it's still
good to consider that always, I believe that was when Steve developed this.

Thanks!

-- 
Peter Xu


