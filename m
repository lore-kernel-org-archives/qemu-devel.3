Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789C4CD37B2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSnb-0006xO-Sm; Mon, 11 May 2026 11:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMSna-0006x6-KZ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMSnY-00026C-TK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778514239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIx5izfemCVe2rB24rHRsc6f0hTNKT7+Si4gXy7dcz8=;
 b=VyyFk0jlruqNBk74mc2PxRgHpLfXFBCDxj9yVd0AnhHG3HDrVI1qqHGDz/6C1CETclF7R7
 9T/WrvXmIcFLKp/eA3AhNHf79zFE4wD0Y9DF6PWG4UzXQfLsXg/PFGP9vK0S8WObq1uhzW
 CQ+MdGczzOlw8778ZiXKUWYRIrcWsZI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-McwY6VHuNu-gdxQ0yJFEJA-1; Mon,
 11 May 2026 11:43:57 -0400
X-MC-Unique: McwY6VHuNu-gdxQ0yJFEJA-1
X-Mimecast-MFC-AGG-ID: McwY6VHuNu-gdxQ0yJFEJA_1778514236
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2826718005B3; Mon, 11 May 2026 15:43:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1249F30001BE; Mon, 11 May 2026 15:43:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 08/10] qom: fix ability to create objects without a
 parent
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260511141420.229023-9-berrange@redhat.com>
References: <20260511141420.229023-1-berrange@redhat.com>
 <20260511141420.229023-9-berrange@redhat.com>
Date: Mon, 11 May 2026 19:43:47 +0400
Message-Id: <177851422776.2961528.2239563098128298952.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EN/CofKq4L96kzo1BO4iOfPtfQ0Z7qshksT3B4TtEP0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAfk2BB1PQNUD1z1+GKS0DFsJSOLFUzsVM2yyp
 y0JTM55ygqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagH5NgAKCRDa6OEJdZac
 5X1mD/452/ipRxcNY3A2ejPURW156SvQbpNgDcp0fRqDaD8UvF0UqtDf82e3R2Uoiq5yzUbPM01
 4uVVJHcMnmdgAmq2TUSoRm+u95h/FMjk/31yImEgl56kDIufjUtEcsicL6pgWJK4S6LwUq6TrMq
 G4K2lrindt9ysQxHgFnesjJ2weVvsfYCQzI7+MA8V9mcwDSR2PnXrHRIul5CpiIldsbwVQwoHMW
 qfx0yGoSNHF7Y2jMnZJljipB+LR9B6KDq1k7lzuBJM6S05uO5CdQZbFJFuk876P67HGutmRGPK1
 czEYhNe/kP/VROzJM4rtdA8KT3Pp3OkCVo4RUfEtXd8wCVi4iZ9kEq0nS/hnUrQpAPYrvZcGZYx
 YvCFWCeX2qLJd/avIm8Jb31Cb8LgfPJcmFqQXNCWRM+ZRvIGHsP25GdurYLqenI3uVCuMW1ZO3B
 NsvorupiIOMZWdXYRJaay3/tBPVL5xsZh0E2Dztv7ijwBAhtb2qLcCe8l7YIC4QVK1iOuLaEllh
 sCCKjH1QWpGnNn0sPkK1f3tBY0jYDSGn1J7K0dp/X/Tail0F/1dHdXkN71ArDlb/5j8rTzNGGgZ
 5wJccdPY0WjT85nyRKUSKy6yqbaQWc8C5XxTaVIC76t5aiifcoLW9GA5RMOvcjRDqADniTVJoai
 Mbjezey+MlRJpyg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 11 May 2026 15:14:18 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:

Hi

> object_new_with_propv allowed id/parent to be optional, in which case
> the caller was expected to own the returned object. Unfortunately a
> trailing object_unref() meant that the returned object was already
> freed.
> 
> It is confusing to have a single method with two different ownership
> scenarios for the returned object.
> 
> Make id/parent mandatory in object_new_with_propv once more, and add
> a new object_new_with_propv_parentless that does not accept id/parent
> at all and lets the caller own the returned reference.
> 
> The helper method has abstracted the way properties are represented
> and setk in order to facilitate the subsequent commit.
> 

set

>
>
> diff --git a/qom/object.c b/qom/object.c
> index 0c13e5ee1ce..e4a01794687 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -868,12 +880,56 @@ Object *object_new_with_props_from_qdict(const char *typename,
> [ ... skip 42 lines ... ]
> +    Object *ret;
> +    struct ObjectNewVargsData data;
> +    va_copy(data.vargs, vargs);
> +    ret = object_new_with_props_helper(typename, NULL, NULL, &data,
> +                                       object_new_with_propv_setter, errp);
> +    va_end(vargs);

va_end(data.vargs), matching va_copy()

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


