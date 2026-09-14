Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CABC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x691m-0007Is-AM; Mon, 14 Sep 2026 11:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x691K-00070l-Cd
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:55:04 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x691G-0003fd-7c
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:54:59 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c08393dfso1498792a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789401297; cv=none;
 d=google.com; s=arc-20260327;
 b=Tihq7NOVMsiLzYLuqwxIou1WkE7sW2KSQYLvB+J31SXe/hMklLU9HbUIrau7Hc1wwt
 47+NDb2P2/pP6kAOr/UkeRIDjX0D5ue/le+VphJdX2RDH8b6CvlSNVbITnmGrW7fXnpx
 EKM8pobYccpUFLvetNIoWRHhsevZpwP9l5MCMJENd294e0W6bfus1veNNa9Dt6LsG2Vr
 2xH6JeDZvA5LXTJNU4HVPkNg0IIwYqQdfNDSWm0PFF2Eq0cm08AhfAOp+sFav9Lq3+3W
 LRs1VatKWGcu079zwQrejevRXiRkjvsNXgtONgRVkV+jHEI+N6krzcoGfPI+ImmUchbs
 Lg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pAhjy6B+qXu9UwHUDI0OXaqGvhoLn10QF5HUQbHR0Fk=;
 fh=v77FpsubiGfTBcF/czgOkaezC5a5Dpjjb5i0Xb4mTDc=;
 b=WTfQk7jBlkHolEnIpATaU+HOyZeqqXKnxsG4n+DAJFUM2y8n3+3lVSKiRn8sCeLEwm
 tNhUg/IAFZLdWhRH5aqks+Zf9NIeMB9/805bLWJksERx6Y30xynV+oJf50zrC/18zho7
 EJD7DZ8aO3NI/57Ob/jQuWt19lHgmv0bV7ygpP5jxGm17BlBlzh6c4R6QVbOrDRKHJdf
 /alc1jlo6aalwJzR8yWBmPNjv2lstmfBlExr+IvQh8STrFyIM6bYt/MUSeHWDj9zfji1
 MZWxTQck5KuOWDRNOkcwATyS9K5u9mmWt7YMUnN5+GkjCgYTZBYNnLNY0219z2DXaWMK
 HjtA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789401297; x=1790006097; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pAhjy6B+qXu9UwHUDI0OXaqGvhoLn10QF5HUQbHR0Fk=;
 b=Q7RqkO74RzLTQVvKPf/KnW3HN1emcwtoDEopQ1Lc1+5bYTl2nUEZ4KyvThZgtv0Ajc
 yz71uA50gwM7Q4M8JZ0TuwiXuXH0yYGVr4MZgYmTfnMRJk55o2VpA7VWIB1QIzVNt2qr
 c2G9EAYEsEP9bebzPpuSEFCegVFIUokbSon0M+He5zAf+t6MmXM7L5NKAlq/a3bM6jN9
 cXLCssm/tpiz6PYSy1GmK7+9f27epjT8u3UC/UnRJJhp20lGUUyDWiL08svbZK2BINmu
 DtVg3H34dvZ4y9wHCXRAX7fUqa3S8u8XVnmXu2J/pmzMKc5G5RmQmI/8c+yQCOK5nwzq
 BDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401297; x=1790006097;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pAhjy6B+qXu9UwHUDI0OXaqGvhoLn10QF5HUQbHR0Fk=;
 b=RkKHRKE23q88VxFEYomlNZ4boWZn4xh1V5KSPI46KHvfLw9Es1SGeU6zDtJLUUch3x
 v0EXKo/Ntm3ryP7j+pl8l4BeJQvVCZvzLpxv7c/IyXJm4wuaGZO/44/lUSf+3/OuGJBA
 CVT9j401MaPl/3t+GvUdQCIiNH0axcN+Wi8YzGYy5Sp8OsMQp/4IMbqu42CJ9G59Jp0Y
 OB2ZA/Nz3gM4SwS6qwrU5WJNRoJv05dywHHHsuoAkt7HETIvelO/OAwdWodQ12Ey5j/Z
 /SXnBnfP5TZEAW+dLcGSRbF3PHprNmtmlakZLAZdYOcrP4h2z2RRuKoAt53m41HHqTGj
 REqg==
X-Gm-Message-State: AFuF++nRzQZ63sQCWUY4qOK2dpwF27/6lW2nKJFS66GNCcYjtZGe5Cg+
 nZqg7pzEBgzJjPCdjKbXlkQuD7ia4O0U5tZE4Yx34sTBg7k3q5SVne/aoO51NXAL5tSOnD1gUKe
 8fJu5xZHG+wVpUI+RMlKol5k3y7Id88w=
X-Gm-Gg: AYBFou1KtOoI1zBr2OJXjcZSCcfs5U+QLWf7gOacZBu98ApHYHahKWy7yWBeDwZp0E4
 dqit+84vOEXWVMtxwbJEPxESLWrZFmU+KI6kcfAeyf9B5LYeRdKiWgRlOal6/tqjrf9lKT3jn3C
 GwaDYQk6wqtOkA1MeLx3thounfEn/9wX8sENdv0/BbDxv+ervnOp/PVi6Ai9eowRGcGcnubjtDd
 +f1HRawZDU9G2J8NacRCbKQs2Rhi0YJ8gBlREMV++1txxm2pqRvMBOGeeGyTrN+Y1qGlT2MkpWk
 1lnFa3dmnatBPaJDePejaT0Aw/1vp2YevJKhUH9lhg5httatN8pPOIH9TFasavHrK6JHSKIMFGl
 LWaRfcF7BeeHgHzTq5e9Z+w==
X-Received: by 2002:a05:6a21:6f12:b0:3d0:57c3:65f4 with SMTP id
 adf61e73a8af0-3db4047dfc7mr6935478637.5.1789401296435; Mon, 14 Sep 2026
 08:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260914-vmem_fix-v1-1-f69ef04a07b0@linux.ibm.com>
In-Reply-To: <20260914-vmem_fix-v1-1-f69ef04a07b0@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Sep 2026 19:54:44 +0400
X-Gm-Features: AcwNN1UR6JzBdCTg71yaTrQ8SiX_NHWbeaIglB0lvP2_T20-lnGz_fsmDd5G8D8
Message-ID: <CAJ+F1CL4q0hbZGpdkzcMG9EgqbhrWaGQODCH819c13hS8ZLecA@mail.gmail.com>
Subject: Re: [PATCH] system/ram-discard-manager: fix
 offset_within_address_space in replay_by_populated_state()
To: Cam Miller <cam@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 David Hildenbrand <david@kernel.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pz2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 14, 2026 at 7:35=E2=80=AFPM Cam Miller <cam@linux.ibm.com> wrot=
e:
>
> Fix bug inside replay_by_populated_state() that forgets to initialize
> MemoryRegionSection field offset_within_address_space. Follow the
> established pattern of calling memory_region_section_intersect_range()
> to accomplish this task.
>
> Prior to commit cc9c77f4ddf0 ("system/memory: implement
> RamDiscardManager multi-source aggregation"),
> replay_by_populated_state() had called
> memory_region_section_intersect_range() in order to initialize
> interdependent fields offset_within_address_space, offset_within_region,
> and size together, as shown below.
>
>     s->offset_within_address_space +=3D start - s->offset_within_region;
>     s->offset_within_region =3D start;
>     s->size =3D int128_sub(end, int128_make64(start));
>
> cc9c77f4ddf0 reimplements replay_by_populated_state() initializing the
> fields of the given MemoryRegionSection instance by hand instead of via
> memory_region_section_intersect_range(). In doing so, it leaves
> offset_within_address_space uninitialized for some reason, as you can
> see below.
>
>     MemoryRegionSection subsection =3D {
>         .mr =3D section->mr,
>         .offset_within_region =3D offset,
>         .size =3D int128_make64(MIN(granularity, end_offset - offset)),
>     };
>
> Consequently offset_within_address_space defaults to GPA 0x0, which is
> incorrect. For example, on s390x, base RAM begins at GPA 0x0 and it is
> problematic to report that a virtio-iommu MR section lives there
> instead.
>
> cc9c77f4ddf0 deliberately calls memory_region_section_intersect_range()
> from other related code paths inside the same file, namely
> replay_source_by_state() and rdl_populate_cb()/rdl_discard_cb(). It is
> unclear why the new replay_by_populated_state() implementation does not
> conform to this same pattern.
>
> The effects of the bug include qemu crashes on multiple architectures.
> The following assertion failure occurs when driving the
> guest_phys_blocks_append() code path, for guests with virtio-mem device
> that has some memory plugged.
>
>     DBG: guest_phys_block_add_section: predecessor->target_end=3D28000000=
0 target_start=3D0
>     **
>     ERROR:../system/memory_mapping.c:222:guest_phys_block_add_section: as=
sertion failed: (predecessor->target_end <=3D target_start)
>     Bail out! ERROR:../system/memory_mapping.c:222:guest_phys_block_add_s=
ection: assertion failed: (predecessor->target_end <=3D target_start)
>     2026-09-11 16:03:57.405+0000: shutting down, reason=3Dcrashed
>
> This crash can be triggered on x86 via the dump-guest-memory QMP
> command. The same crash can be triggered on s390x by restoring VM State
> that has been migrated to a local file. (I used libvirt to manage this
> migration restore operation, namely command virsh managedsave then virsh
> start.) Applying the fix resolved the crash on both platforms.
>
> Fixes: cc9c77f4ddf0 ("system/memory: implement RamDiscardManager multi-so=
urce aggregation")
> Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> Signed-off-by: Cam Miller <cam@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks

> ---
>  system/ram-discard-manager.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
> index 4e8816e5a2..e9a609e5cd 100644
> --- a/system/ram-discard-manager.c
> +++ b/system/ram-discard-manager.c
> @@ -238,14 +238,15 @@ static int replay_by_populated_state(const RamDisca=
rdManager *rdm,
>              }
>          } else {
>              if (in_run) {
> -                MemoryRegionSection run_section =3D {
> -                    .mr =3D section->mr,
> -                    .offset_within_region =3D run_start,
> -                    .size =3D int128_make64(offset - run_start),
> -                };
> -                ret =3D replay_fn(&run_section, user_opaque);
> -                if (ret) {
> -                    return ret;
> +                MemoryRegionSection run_section =3D *section;
> +
> +                if (memory_region_section_intersect_range(&run_section,
> +                                                          run_start,
> +                                                          offset - run_s=
tart)) {
> +                    ret =3D replay_fn(&run_section, user_opaque);
> +                    if (ret) {
> +                        return ret;
> +                    }
>                  }
>                  in_run =3D false;
>              }
> @@ -257,12 +258,12 @@ static int replay_by_populated_state(const RamDisca=
rdManager *rdm,
>      }
>
>      if (in_run) {
> -        MemoryRegionSection run_section =3D {
> -            .mr =3D section->mr,
> -            .offset_within_region =3D run_start,
> -            .size =3D int128_make64(end_offset - run_start),
> -        };
> -        ret =3D replay_fn(&run_section, user_opaque);
> +        MemoryRegionSection run_section =3D *section;
> +
> +        if (memory_region_section_intersect_range(&run_section, run_star=
t,
> +                                                  end_offset - run_start=
)) {
> +            ret =3D replay_fn(&run_section, user_opaque);
> +        }
>      }
>
>      return ret;
>
> ---
> base-commit: 2242ae1f7bdcf76e78cf8a987118952fc6c9a469
> change-id: 20260914-vmem_fix-c80d75571aa6
>
> Best regards,
> --
> Cam Miller <cam@linux.ibm.com>
>
>


--=20
Marc-Andr=C3=A9 Lureau

