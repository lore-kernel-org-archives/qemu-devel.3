Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47497C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WM6-0005X1-Nj; Mon, 07 Sep 2026 06:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x3WM4-0005Vp-GP
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x3WM2-0000nm-FV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788776013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+jdEf5W70qK0a7enGXVMjZkE6k9WDNDbLDEOIRWJ+w=;
 b=Z7lH3wfGVqKh6IC82HVNYf3AzYG6vqTZXwYfWbRTPwpaUwqSwafiGbrIhQpSlnOhiW7XWW
 Vui70oAF7E9tgGCKIzmne4ReeDo6X7uTQfztOAQxIUfRbviPOawANxl3tLJClXMtxOtbws
 gpRz6eb/SDPFWY7gxogH7cVpFrQuQCQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-lSM9MMLpPpCLOOqymFsqYQ-1; Mon, 07 Sep 2026 06:13:31 -0400
X-MC-Unique: lSM9MMLpPpCLOOqymFsqYQ-1
X-Mimecast-MFC-AGG-ID: lSM9MMLpPpCLOOqymFsqYQ_1788776011
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398d0010cfaso6810969a91.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 03:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788776011; cv=none;
 d=google.com; s=arc-20260327;
 b=ir3QZ10wbnTwfZfpKN9HElA4C0/+Gw4gBYchYlloTVlVDEhSB1OIrajhzwZX5ZIFTv
 mwhomFAFZhdVwbgjZanBNCop5zdyhwg2p+7L/2btbTz1aCIfXHwEWq7IydJOsT3vYr60
 dVCIZe8aXjeIEKMd4M212ECptcx7PENcPkCm+FPekxY7uyyLmRwNxY5g0BiQI86Q/J2x
 j7yLfR1WBRmuPFLnyulxXh2IPn8uwPOeUkgQ2LfDMr1RGB2nlIe4j0pc52eR8bRZm4dy
 FdmrPPIhhgk3TuBPFKbwLOb8DMhrETBsuhJcDmlHLoypcmuPGtqTHW5uqJEWvXeh2G5x
 0ADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N+jdEf5W70qK0a7enGXVMjZkE6k9WDNDbLDEOIRWJ+w=;
 fh=vv5bYMjP2MvqPM91fMZ+yBkFsR05uCsdPuHagAZsWRs=;
 b=iJAIolk1sD0TwXvAcXwuWOhQwOTCExaSDNAt/yg1XwT3CGLwJctXg0SPcrLT8TKBeS
 0GbmT5fXkiguPCdoAdhcZRdjGMcmG+akpuSs4V2Twa5Zq231FeSrK10hy6FCwLGP6rdl
 mEDaVLEITxN3VrlDivKlPspChBmnKmJ/XsT2T3UHb+eGiutEh34ALYXC1eaBmbV4ZYxU
 8YbyO6mvo8Z6ZHUJTmqCBiO/eSZeuYY7vHDpLlfGotuuaAGpyPTTXZXNpoE4fYaaXFQy
 rbSaigVLGfT6jLR7iU/Q2lcDHhcBu9rq+hIgCwLcP50xP1smXomozIn7Pssj0oRjPIKS
 qFjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788776011; x=1789380811; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N+jdEf5W70qK0a7enGXVMjZkE6k9WDNDbLDEOIRWJ+w=;
 b=hVkkgvaVfno0HNyJ6Cb0NoNanJfZ0+HUYe3L7CECxlzGep/hs1FD0FitAJzsC8inrr
 i65yCf6o3Otmxz0AzQGxtmPdROljj/VdZdjB2LvNWRuxRXDFnEf6iM786C3cNZoc6Wl5
 c3yQVAQMo8YcTaenkipVLmvNyIZAJ81ySnYlpkVjF9sdhWLoUs4G5JocR1ap3v2MAHgP
 M5at8nIN9CK0oRgOauwIp5jUjcVoSRYJXvcK+GcR1/tP2LLQmvRJO32xO6tKb7cYj4hw
 pHpB8oeE7AaJWjfEKC+gaAWIjS9BFoQp/7w/zxn9enYRWgpozRXydlOWdiTr3g8GsfMu
 ev0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788776011; x=1789380811;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N+jdEf5W70qK0a7enGXVMjZkE6k9WDNDbLDEOIRWJ+w=;
 b=lZFGP4d0DllU2uyuweY5RQW1JjmBqUOBTZv1xTZGgcxJM20+OywdVxO8RbISHpeU2z
 YLtca+numX0WtcucyQ32pH0PA1dBNxO+l5Es5IJHdLTP2aGEqQNifkVf0ypqOeh29BsH
 DCezs7RDiIPdOLHtOi/W0kDVp2mKizSIK8bnonFKvqSW0DIvclS+dqhiUugbpZGqq8z7
 QQxvEqVJbXAsltdSFHyl2DqMyj+4lxcqw5eqfpwFjK1iNAHhD4SbVyUqDmi+jTNC5cgm
 mthqoE3C83RDlFsBm25exCPQwxyAVLhUTJl8pLfq/uE8DdjzFxTHhG9r1D9N2dd7wtH5
 gh9w==
X-Gm-Message-State: AFuF++mhKmgt9F1RzoM4hBb8ISAzJyq7HMwsqPfbs/uZdxhZdRRzAYRx
 erhzi51dtBp0GF0THerAkI3lVxfnvvfl4N7No77KYwnIqGOkgWdD1atvUoDZ5gPjWw4ZIlcVYmB
 xlhX9dZnlZ+t1pWZKUlOwoAmB3iWn7KagV1jveMT4o1QYi9K//Y/uQU9Y+Jdi0z6ZGlGFlszFeE
 jLL/Q9IR8eqilz56+OE9PFqr109ovkubA=
X-Gm-Gg: AYBFou0nrRm3yf9m0rEAgaHCY7w8uesbgXY7aVL6HK9l+xWOAPDcEZPX3Wcad0VlHO2
 5JRUhRInm7mypieZt0zP/+FiVnndzuY4MHOoBU+iTEnMvP2VbB0U/C0IEalSiAZy3kVCMvU163a
 ra+00ErYOc4CZcQCJutT73XOYaF0ykHXXQiyf4zFNxz4QhprESnUkZxn2/ADtScBmRuFko5uW7g
 xCf90KU12v2G8UZajaJtOWYQ187cYqwl+/diLmWo9SKnFdeIiiUXJc/W3aSQqpQj9pxmnW8QEhx
 mg==
X-Received: by 2002:a17:90a:d004:b0:398:c9be:cca8 with SMTP id
 98e67ed59e1d1-39b2609f363mr38629083a91.2.1788776010665; 
 Mon, 07 Sep 2026 03:13:30 -0700 (PDT)
X-Received: by 2002:a17:90a:d004:b0:398:c9be:cca8 with SMTP id
 98e67ed59e1d1-39b2609f363mr38629025a91.2.1788776010233; Mon, 07 Sep 2026
 03:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
 <20260906-nohmp-v1-4-daee96491c43@redhat.com>
 <ap6JAy9jaHzDakvw@redhat.com>
In-Reply-To: <ap6JAy9jaHzDakvw@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 7 Sep 2026 14:13:18 +0400
X-Gm-Features: AcwNN1WiHN_rDHAQsBoIZSnMVHrZPN1Ey_MeeGxzZkqyXVr4rf4a-vdzLS_JjKA
Message-ID: <CAMxuvaxhMVUNWssTp+MBfWSS9CowUipoRNbemHioz6Rf5M55EQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] tests/qtest: add qtest_qmp_job_wait()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Mon, Sep 7, 2026 at 1:51=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Sun, Sep 06, 2026 at 12:42:35PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Add a helper to wait for job conclusion, used in next changes.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/qtest/libqtest.c | 37 +++++++++++++++++++++++++++++++++++++
> >  tests/qtest/libqtest.h | 11 +++++++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> > index 28bb72bfaecf..370f79a3b6fb 100644
> > --- a/tests/qtest/libqtest.c
> > +++ b/tests/qtest/libqtest.c
> > @@ -984,6 +984,43 @@ void qtest_qmp_eventwait(QTestState *s, const char=
 *event)
> >      qobject_unref(response);
> >  }
> >
> > +void qtest_qmp_job_wait(QTestState *s, const char *job_id)
> > +{
> > +    QDict *response, *data, *error;
> > +    QList *jobs;
> > +    const QListEntry *entry;
> > +
> > +    for (;;) {
> > +        response =3D qtest_qmp_eventwait_ref(s, "JOB_STATUS_CHANGE");
> > +        data =3D qdict_get_qdict(response, "data");
> > +        if (!strcmp(qdict_get_str(data, "id"), job_id) &&
> > +            !strcmp(qdict_get_str(data, "status"), "concluded")) {
>
>
>
> > +            qobject_unref(response);
> > +            break;
> > +        }
> > +        qobject_unref(response);
> > +    }
> > +
> > +    response =3D qtest_qmp(s, "{ 'execute': 'query-jobs' }");
> > +    g_assert(qdict_haskey(response, "return"));
> > +    jobs =3D qobject_to(QList, qdict_get(response, "return"));
> > +    g_assert(jobs);
> > +    QLIST_FOREACH_ENTRY(jobs, entry) {
> > +        QDict *job =3D qobject_to(QDict, qlist_entry_obj(entry));
> > +        if (!strcmp(qdict_get_str(job, "id"), job_id)) {
> > +            g_assert_null(qdict_get_try_str(job, "error"));
>
> If "job" did contain "error", then wouldn't we have hit
> a SEGV in the qdict_get_str() call due to missing 'id'
> field.

query-jobs returns [JobInfo], where "id" is mandary and "error" optional.

>
> IOW, we should likely validate this is NOT an error
> response first.

that's g_assert(qdict_haskey(response, "return"))

>
>
> > +            break;
> > +        }
> > +    }
> > +    qobject_unref(response);
> > +
> > +    response =3D qtest_qmp(s,
> > +        "{ 'execute': 'job-dismiss', 'arguments': { 'id': %s } }", job=
_id);
> > +    error =3D qdict_get_qdict(response, "error");
> > +    g_assert_null(error);
> > +    qobject_unref(response);
> > +}
> > +
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


