Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEE8CA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 21:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoU1X-0004Gu-TG; Tue, 19 Aug 2025 17:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoU1W-0004Gm-6z
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoU1T-00080H-DL
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755639458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75nqkrcocBhgG3EhI4PfpaRFKGSprTSs8iF4/oao/+Q=;
 b=h5ikOcbUPCCPbJsKtTt12fgDwWLgsBtfSnLw2PgXDdIgwssYgDRGAKG6qOJtV1d2wIkY2s
 rmC0/msA/p+lLT4oNxaec4ZqxghZyUEFWOw+UXoPOD6K3rAMUWJf/6taI7FFJYRejTIhhB
 GcwGou5d2VjG+rieTYgYt69+FGxwKWk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-aZ0F6ZgNNl255f5bcB7s7Q-1; Tue, 19 Aug 2025 17:37:37 -0400
X-MC-Unique: aZ0F6ZgNNl255f5bcB7s7Q-1
X-Mimecast-MFC-AGG-ID: aZ0F6ZgNNl255f5bcB7s7Q_1755639456
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2445820337cso62374555ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 14:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755639456; x=1756244256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75nqkrcocBhgG3EhI4PfpaRFKGSprTSs8iF4/oao/+Q=;
 b=i08uiUt57IqV9/oAmfvKpvETElxIx2I+fEXhiVLWfMnnlo9AVe7IEJfkQyJz7GSTOT
 N7jm6AP3A1siupa5hTsi6cXon/mifVixL0wkJOOTIrLUQVpFODzMjvs/4VimIsMscs5S
 lFzIEnaHg9PDVybZaVIuuvg4PbbkjLZdoZn0WShqyvtxoXU/ig9VyDE9FC3YldLJMmRL
 4AIHA2numFELTBweTUMTCYU/ecVZp2hoX2hlpZW40DP6zIjtsVfAzdd956SrxjTPa18d
 HSegyNaDAlWR8jfXTPmJCd0GfPYi6cCrb45GOSQl5OW8QCHA/KtPepSUkI2VrfY3ckHz
 ZKyA==
X-Gm-Message-State: AOJu0YwRtrLCM3tzqLYCbtmSk2lpkvldEn1BB5G3+1dGLMM+m6v+LT2F
 7JUgRlwowVCT2np24SHx4XGTbuTCbffTrJy+YdY425Hld4jOv6A/HdubfQR6yHGnfHmA2XMEaOa
 gjeIihPpn4x44kpLrVaTMNpeoWnbCK8YT4tTiFXzlYK3VV+TTF+nhD4V5AawrxvhmykoxOo7exN
 0+MSn+Ep9Arf8vEUs5LhWMFmSFrQSATVs=
X-Gm-Gg: ASbGncvTnhLm5MizMA7RZDPoJEpyxuyABJuuI/CJlYyZN5ISe7rtEJZmt3Phg7GJEz7
 CQEg7msUjxRZaLCIuLYscxuQsyIxt2AO1YFK1xX1/KGMrJftQ9X0KsPEy/T2HNc0AID1YrI4OOj
 yTtksJ9pR5CR7w9x1VFyoKwBqXAo6bmf4/I6LRT265ot1GK8fiBCfD
X-Received: by 2002:a17:902:e80b:b0:237:e696:3d56 with SMTP id
 d9443c01a7336-245ef22f57amr7346415ad.32.1755639456247; 
 Tue, 19 Aug 2025 14:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKZ5s7pFXpjLEm4XCDKgaOxEeAL0+H9o8Nm4xRoPj0oYs4GPPz8BmooywTAaGdycTPKakD4Cu6hCmumyri8Bc=
X-Received: by 2002:a17:902:e80b:b0:237:e696:3d56 with SMTP id
 d9443c01a7336-245ef22f57amr7346165ad.32.1755639455914; Tue, 19 Aug 2025
 14:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-13-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-13-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 17:37:23 -0400
X-Gm-Features: Ac12FXyrM92Ulz9MYzgDx_71yV1AW2X4gR-y6QRi3DGOyuZz4Ztzr8CytewFR0Q
Message-ID: <CAFn=p-arDjfPZoyEmrLGuuOkcOPK7zbG66ecKxVdhp2hUTN4pQ@mail.gmail.com>
Subject: Re: [PATCH 12/14] iotests/147: ensure temporary sockets are closed
 before exiting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 15, 2025 at 10:32=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> This avoids the python resource leak detector from issuing warnings
> in the iotests.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  tests/qemu-iotests/147 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
> index 6d6f077a14..3e14bd389a 100755
> --- a/tests/qemu-iotests/147
> +++ b/tests/qemu-iotests/147
> @@ -277,6 +277,7 @@ class BuiltinNBD(NBDBlockdevAddBase):
>                       } }
>          self.client_test(filename, flatten_sock_addr(address), 'nbd-expo=
rt')
>
> +        sockfd.close()
>          self._server_down()
>
>
> --
> 2.49.0
>


