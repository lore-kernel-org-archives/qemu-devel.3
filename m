Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220C1FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 07:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJnf8-0002XJ-1o; Mon, 04 May 2026 03:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJnf4-0002X7-OY
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJnf1-0003L0-1X
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777879449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EiI0SJbREZyq9IUI8pw0wwpx48RcV0kNF2anm77UC94=;
 b=aEC+Ab8UP011oBkkcIA0VACicO4deNrt4QfiLrOpv9CFR04qv4KjLNP8xm363TIw+trYiy
 oKssMC504u1T0zvmWHFZy4K9uXS9xDEriaElosIxcUcLhlJiH5JC//HCp2VUB/SSzWluCa
 /Ih8x7kg+8cd/EyTEUcKk/IhkxyM26Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-Wl0BUVUtP0u0XS_jcuhnGA-1; Mon,
 04 May 2026 03:24:08 -0400
X-MC-Unique: Wl0BUVUtP0u0XS_jcuhnGA-1
X-Mimecast-MFC-AGG-ID: Wl0BUVUtP0u0XS_jcuhnGA_1777879447
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62AFD19560AA; Mon,  4 May 2026 07:24:07 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD3BC1801481; Mon,  4 May 2026 07:24:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 27/41] system/qtest: free log path on finalization
From: marcandre.lureau@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, armbru@redhat.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAFEAcA9HMUcY2kVXgwxjZTptAtyhbVfFq4rPSp5buQ-9jvS8mw@mail.gmail.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-27-c413f3605311@redhat.com>
 <CAFEAcA9HMUcY2kVXgwxjZTptAtyhbVfFq4rPSp5buQ-9jvS8mw@mail.gmail.com>
Date: Mon, 04 May 2026 11:23:58 +0400
Message-Id: <177787943831.2741407.13660021224985138242.b4-reply@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rp/qawBfra7KHwxi88RWGhIylF0XKFC9LIiL4OmS6So=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+EmOLCPecn1ohxEDBiZlq+nbtQDU1FM+WhOVP
 /PMz7yw+QeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafhJjgAKCRDa6OEJdZac
 5cafD/9RuCHfWiXUdU4xpVtoMPii2hHJhoKDscOUPcT0auXjwjsAjAY26KtGvWJX4qhZNrxs4do
 0h3VJNI1f2CSqhH9HF+ebyLzr14IIJovjwS2/0fyvv6FinRmBqHJBgx9gSxS/ewXg2NoBCfH6d9
 Hi0s2ZfGEKY7aYWxxuQFdrjZLhJvjsUpyIb9i2ONipsz6olBdaGE0jdeeLxU2uOvIfeR1Ip+keH
 59vh9e8Gs2BWpO4d84LN1BfU/xLbVdTU6ku5sscRpJYaxDtPl3wrVXwe+AtUAI4JLmiw3BxQCUu
 Wcp/3KcSYmtZQt96vQ3FUatIGl00PvPIEosUp1589OHjQ6XkHzLR1UaSpwNf0XaUS1APgidngg3
 A60l+YWfhwpQJ4BYR9I7fwgEV3x7JN/J9EcW9Yu7kLBSEWUdCfYyR62Hm66BQwq+WOR184IiNBW
 v2Fyz/TPVqFUMk6kzxYbU8E9k7W5SZSaeNzqJdpDoweXZ/MJBfvRj7BYQbUnYXCG/DQ3ih9AHlc
 WUjNp0+LfgEEx7P408iKZI5+sZ308dIGCJlCqnqOZs9kuwC4ufhmstT7W/4LaD+m6/QIbY+N0xQ
 xgYjTpUaqQJkiv1yPfOtUGpLyjcJe61WX+bscouJ9RZUIWUg8M553ckkzGL1INBwNDS+zurTvba
 4hFAhsxAEUu6FSg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026-04-30 17:01:14+01:00, Peter Maydell wrote:
> On Mon, 27 Apr 2026 at 20:46, Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
> 
> > qtest_set_log allocates log via g_strdup, but no instance_finalize
> > existed for the qtest type.
> >
> > Fixes: 6ba7ada3559e ("qtest: add a QOM object for qtest")
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >  system/qtest.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/system/qtest.c b/system/qtest.c
> > index cf90cd53adb..e9e5773341f 100644
> > --- a/system/qtest.c
> > +++ b/system/qtest.c
> > @@ -1020,10 +1020,18 @@ static void qtest_class_init(ObjectClass *oc, const void *data)
> >                                    qtest_get_log, qtest_set_log);
> >  }
> >
> > +static void qtest_finalize(Object *obj)
> > +{
> > +    QTest *q = QTEST(obj);
> > +
> > +    g_free(q->log);
> > +}
> > +
> >  static const TypeInfo qtest_info = {
> >      .name = TYPE_QTEST,
> >      .parent = TYPE_OBJECT,
> >      .class_init = qtest_class_init,
> > +    .instance_finalize = qtest_finalize,
> >      .instance_size = sizeof(QTest),
> >      .interfaces = (const InterfaceInfo[]) {
> >          { TYPE_USER_CREATABLE },
> 
> Doesn't the chr_name string have the same issue?
> 

Indeed. It doesn't trigger in the test because a bare qtest object
has NULL chardev. But we should fix the leak nonetheless.

> This pattern of "the object has a string property, and the
> char *field that backs it is allocated if we give the property
> a default value, and the setter has to free the old value
> and strdup a copy of the new value, and you have to remember
> to free the string in finalize" seems to be very common.
> I wonder if there's some way we could make this less
> error-prone and boilerplatey?

I don't have a good solution to propose but to have a new optional
"free" callback + pointer and error-prone pointer arithmetics. I am not
sure this would make things simpler.


