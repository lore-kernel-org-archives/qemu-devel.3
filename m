Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5645FCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUh67-00068w-Pd; Wed, 03 Jun 2026 04:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wUh66-00068c-1A
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:37:10 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wUh64-0006sA-DC
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:37:09 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3075afe5247so27906eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 01:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780475826; cv=none;
 d=google.com; s=arc-20240605;
 b=CG3rj9Ty3kGpM5bySIe+jbiLYCtwHJ3CywltYRqzh/sTYgeCzlSrTeG+7/hu76zKm3
 5I38NBDi5b9NqqopbhFLnA1JBb55ksttdWLWpbDLI+iZ0x9brRd2+F3rQPjd0aPeYf7y
 sJIUs8fGxVBn/s1Vl9tcig1Kp3+LKlPP66MLvVKnA3BwlVWDONa1B8frYHs1GWG9c/4y
 7Le5o4QBDvWOYEJYstaCNvup+DjpJ3olqS48Cm8aUzlHTKqGrLOtgeHhaUxitePsdnid
 tuDOqMWZYt5/oBosxkXaphzBtRY9A5x2x4V1w9fYHfy5hJuum7CsX9IxooOM93ccA+aX
 AkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OvZJrmEy64tq3WyQB3acgCZUJZT0YGXjdNcY6sseLf0=;
 fh=sE2OBjZdF8PLYicXFyUM4w7ozjweWx0plNt+fUrokJ8=;
 b=CyS/k5u+4ABioUv5dJJkOhDeNibOlFmP8QmLn1GEKSG5deeDWOnTkMITh47qVcCSFp
 6SkLQaTKCVJHi5pVOtqDihi1bkxqbRP5HgQn9Bda4DNSSQ7SuZqUwA0QWVKryT2iLBoy
 3lwYswdnY3MGSDkUfgJUEjFeYEZKEdxuXQzid6kQtRT8rr2ipdoV5nj1AO6zJCQIQPSz
 HhhcwQ8nj0z6RsHw4h8xLCaerjJVEe+ID2hueniaLulL01ldnbnc2FCzFJkrg/1b7irW
 qZcoMnczofNzGs0O1dLzS+5A9Q4t43SDv3e2+T9QfhFoXveyVRDV7P8aGokwPcGP9XX1
 6FsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780475826; x=1781080626; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvZJrmEy64tq3WyQB3acgCZUJZT0YGXjdNcY6sseLf0=;
 b=haskS+8K/SPULcGBJsE1ZStfp10Xvr+/2zws7gc8rZHSsHyZ6+Gh0rmksYaw5a78ru
 /WrJNT1cLpxZS7UsZKUEtJlI7JIL1MSu+iCzQurZjVw1srqo6K337xnV4JbzR3/owIDW
 6IzFqATiIE+CU2dgJxJgccyQUpiLjPoIiQuClXFdlWjaFhTst7P7cWM1PhAmY8phLVVA
 WAFS491ktFnXbKSrvckLTWfBPI2E4G9kNKjrq9eXr35+0LQgpCT9FXdpOpjp3Yq95hSD
 QNLJkJQyujoGKF4ScF4MyYreegX5JslGr3d1heGBx6Fb00kZpfVXAc6RI/vOVKrS50KF
 9Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780475826; x=1781080626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OvZJrmEy64tq3WyQB3acgCZUJZT0YGXjdNcY6sseLf0=;
 b=YZYeFGmTpCm8V2Z6k8ODn1HQ0KNXsEneIrCQsRd6iafco+bMbxPPFkdDIJHXqkWBVp
 Q2pBXLrVdTGHTt2IP8dP+VYA8iCnt+scVst1jEWLu1BJR0kukKAJU2g5oK7L+bOyQcwZ
 Z9B6puh3kiuHpuv0C/Xyqt7WZhqATduS45f3RyZ3kQkSp7ZQjJGvecka5Enrg028qb0j
 MB3sBvuuQ3bgOrjG1C6JsvewFwdNvkXQLo5g79dHhc7/fN+y9YXnqLPFPfNAukuyD+8g
 EyGFowD4cOirb9lETsPZ3dkYcBrHmN9BAoGCsUwdULGQVH+URxy5RfdDBZWWCAhZmepu
 +ntA==
X-Gm-Message-State: AOJu0YxsrPaFg+D/i63W1mDWvTjT51CMiJsyS48h4Annjid2eDuPGKy8
 LxM5jjhgtDILM8dggWjhlaRK9DBaQinAc1Z7BgOTMWw++lU402BwvZ5Js2lAQj271vKw2kbd/bL
 x5UXxW+f/VYSwX40/0XGA35rnC5bKvgA=
X-Gm-Gg: Acq92OGmuis885jijEQXsfLXjwankrH8v3bUBOraXsTs0d9TQfvTU34fKAaogKPv1xe
 EwGO4O0TrGBcdOxG0jGtr+/SGHp4lPTwIadpRCnjA9bx4o2zR6P5BEaXDDk8lQLULoQdw3YaDlB
 sv2IHnJntnZlrGEzVRUMbnGEvuhu6cHqVzbjJ68UHQQDObsPl5k8aCicdJ2P3YPZdx9BIBYAPD7
 UodsWctxsL/sA1BIM8nFQAcJtIOQFG0WOspbi+bDG4MOlL18FEOMKzZRjZ0deejJXA/j9Vr5vRF
 fWDbXhEFKR+XQiNn82APfzc3mv48bPr1t7/WDBjpKT+XqpSI6Q==
X-Received: by 2002:a05:7300:df4a:b0:2ed:e16:6b4a with SMTP id
 5a478bee46e88-3074fc4eb73mr1223503eec.32.1780475826203; Wed, 03 Jun 2026
 01:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-17-pbonzini@redhat.com>
In-Reply-To: <20260108131043.490084-17-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 3 Jun 2026 12:36:53 +0400
X-Gm-Features: AVHnY4IMV2tonU5IL68xxsIVKeMJFh68kMYU8BSz3Le0qc-8aWYPStTgUWt2BtE
Message-ID: <CAJ+F1CLTM64zfr4e6b9X1zAqs_+=rRZ27KCEQLG_Fxj7ybQWaQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] rust/tests: QAPI integration tests
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Jan 8, 2026 at 5:13=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/tests/meson.build          |  21 +-
>  rust/tests/tests/integration.rs |   2 +
>  rust/tests/tests/qapi.rs        | 444 ++++++++++++++++++++++++++++++++
>  3 files changed, 464 insertions(+), 3 deletions(-)
>  create mode 100644 rust/tests/tests/integration.rs
>  create mode 100644 rust/tests/tests/qapi.rs
>
...
> +    let qsa =3D to_qobject(&expected).unwrap();
> +    let json =3D qsa.to_json();
> +    assert_eq!(
> +        json,
> +        "{\"port\": \"port-val\", \"keep_alive_idle\": 42, \"host\": \"h=
ost-val\"}"
> +    );

We need to fix the field names to produce the correct wire format:

index 41ed83c381d..3e0bd237d8c 100644
--- a/scripts/qapi/rs_types.py
+++ b/scripts/qapi/rs_types.py
@@ -163,15 +163,21 @@ def gen_struct_members(members:
List[QAPISchemaObjectTypeMember],
             typ =3D 'Box<%s>' % typ
         if memb.optional:
             typ =3D 'Option<%s>' % typ
+        field_name =3D rs_name(camel_to_lower(memb.name))
+        serde_rename =3D ''
+        if field_name.removeprefix('r#') !=3D memb.name:
+            serde_rename =3D '#[serde(rename =3D "%s")]' % memb.name
         ret.append(mcgen('''
 %(cfg)s''', '''
 %(skip_if)s''', '''
+%(serde_rename)s''', '''
     pub %(rs_name)s: %(rs_type)s,
 ''',
                          cfg=3Dmemb.ifcond.rsgen(),
                          skip_if=3DSERDE_SKIP_NONE if memb.optional else '=
',
+                         serde_rename=3Dserde_rename,
                          rs_type=3Dtyp,
-                         rs_name=3Drs_name(camel_to_lower(memb.name))))
+                         rs_name=3Dfield_name))

