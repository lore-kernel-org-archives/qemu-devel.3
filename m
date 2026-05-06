Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FF4CD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 08:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKXOc-0001F5-Ay; Wed, 06 May 2026 04:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wKWwG-0000i2-5I
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:45:01 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wKWwC-0005Cj-E7
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:44:59 -0400
DKIM-Signature: a=rsa-sha256; bh=pdH6ElsBuMFpxOZq7ScCr9EATvQzqeNz/ILpby2zqJM=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1778053490; v=1;
 b=ZuOVNUDMTsEh/76zfSmr00pChe3+Do3M6XwOJr8ZM7IahM3aPijtsld2jXApQTlHYyaPKVrQ
 9wpmA6xdlxfhXRr0gjb+K09G14Z3S+Q7+gxrdMtSR3PuYJLNpz/+ASo0A4gxFhnvdYLsX2Tf6lY
 TfNECEzwQA2Cjl6swlY3IMRyy7PU+/jXujkwcShtR/C6GYIc/isLYtHBnyYRWBbfCh9eKlGyhQs
 pJof8Sa0QEIa3SQTqrdOPsZTjuUv3U9Q1hHigwT1yytJtJ0eJl9diGNIkFBKEw19HpSJJqQTGgW
 SGG0RgSkUfaJ0x7Q674hhFV6x0deHfYWAaut5P+2itgqg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 3452A20E6C;
 Wed, 06 May 2026 07:44:50 +0000 (UTC)
From: ~bboe <bboe@git.sr.ht>
Date: Tue, 05 May 2026 19:26:38 -0700
Subject: [PATCH qemu 1/3] Add OPL3 support to SB16
MIME-Version: 1.0
Message-ID: <177805349017.32250.15775019749727013358-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 30
X-Spam_score: 3.0
X-Spam_bar: +++
X-Spam_report: (3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 HK_RANDOM_REPLYTO=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 May 2026 04:14:14 -0400
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
Reply-To: ~bboe <bbzbryce@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bryce Boe <bbzbryce@gmail.com>

The existing SB16 device does not have OPL3 support, and the AdLib device
supports only OPL2.

This patch hopes to expand that support by leveraging Nuked OPL3.


The end result of the patch can be verified by the following OPL test. Assemb=
le
and run using the instructions below. Observe that on existing Qemu builds no
audio is produced with the sb16 device. Similarly observe that adlib is missi=
ng
sounds which sb16 on this patch produces:

```
; 512-byte boot sector demonstrating OPL3's extra 9 voices.
;
; Phase A: key-on 9 voices in the OPL2-compat first register set
;           (D-F#-A in octaves 2/3/4). Both adlib and OPL3 sb16 hear this.
; Phase B: 1.5 s later, key-on 9 voices in the OPL3 second register set
;           (D-F#-A in octaves 5/6/7). adlib has no second register set, so it
;           hears nothing extra; OPL3 hears the chord double in span.
; Phase C: hold, then release everything and halt.
;
; Build : nasm -f bin opldemo.asm -o opldemo.bin
; Boot  : qemu-system-i386 -fda opldemo.bin -audiodev coreaudio,id=3Ds0 \
          -device sb16,audiodev=3Ds0  ; Replace sb16 with adlib to test OPL2

bits 16
org  0x7C00

%define ADDR_LO 0x388       ; first register set: voices 0..8
%define ADDR_HI 0x38A       ; second register set: OPL3 voices 9..17

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, ax
    sti

    mov si, message
.print_loop:
    lodsb
    test al, al
    jz  .print_done
    mov ah, 0x0E
    int 0x10
    jmp .print_loop
.print_done:

    ; Enable OPL3 mode (writes register 0x105 =3D 0x01 via second set)
    mov dx, ADDR_HI
    mov al, 0x05
    out dx, al
    inc dx
    mov al, 0x01
    out dx, al

    ; Program 18 operators in each set with the same simple instrument
    mov bp, ADDR_LO
    call program_voices
    mov bp, ADDR_HI
    call program_voices

    ; Lower chord is always sustained; upper chord pulses on/off so the
    ; OPL3-only voices come and go without any silence between cycles.
    mov bp, ADDR_LO
    mov si, chord_low
    xor dl, dl
    call play_chord

.forever:
    mov cx, 30
    call wait_ticks            ; ~1.6 s, lower chord only

    ; Upper chord on (OPL3 voices 9..17; no-op writes on adlib)
    mov bp, ADDR_HI
    mov si, chord_low
    mov dl, 0x0C
    call play_chord

    mov cx, 30
    call wait_ticks            ; ~1.6 s, both chords on OPL3

    ; Release upper chord
    call silence_chord

    jmp .forever

play_chord:
    mov  cx, 9
    mov  bl, 0
.each:
    mov  al, 0xA0
    add  al, bl
    mov  ah, [si]
    call opl_write
    inc  si

    mov  al, 0xB0
    add  al, bl
    mov  ah, [si]
    add  ah, dl
    call opl_write
    inc  si

    inc  bl
    loop .each
    ret

opl_write:
    push dx
    mov  dx, bp
    out  dx, al
    inc  dx
    mov  al, ah
    out  dx, al
    pop  dx
    ret

program_voices:
    mov si, instrument
.next_register:
    lodsw
    test ax, ax
    jz .program_done
    xchg ax, dx
    mov bx, operator_offsets
    mov cx, 18
.each:
    mov al, dl
    add al, [bx]
    mov ah, dh
    call opl_write
    inc bx
    loop .each
    jmp .next_register
.program_done:

    ; 9 voice-level connection registers: 0xC0..0xC8 =3D 0x30
    ; (bit 4 =3D left speaker, bit 5 =3D right speaker, bit 0 =3D FM connecti=
on)
    mov bl, 8
.connection_loop:
    mov al, 0xC0
    add al, bl
    mov ah, 0x30
    call opl_write
    dec bl
    jns .connection_loop
    ret

silence_chord:
    mov  bl, 8
.each:
    mov  al, 0xB0
    add  al, bl
    mov  ah, 0
    call opl_write
    dec  bl
    jns  .each
    ret

wait_ticks:
    mov  si, cx
    mov  ah, 0
    int  0x1A
    mov  bx, dx
.poll:
    mov  ah, 1
    int  0x16
    jz   .nokey
    mov  dx, 0x604           ; PIIX4 PM1a control (PMBASE 0x600 + 0x04)
    mov  ax, 0x2000          ; SLP_EN=3D1, SLP_TYP=3DS5
    out  dx, ax
.nokey:
    mov  ah, 0
    int  0x1A
    sub  dx, bx
    cmp  dx, si
    jb   .poll
    ret

chord_low:
    db 0x81, 0x29        ; D2  (block 2, FNum 0x0181)
    db 0xE5, 0x29        ; F#2 (block 2, FNum 0x01E5)
    db 0x41, 0x2A        ; A2  (block 2, FNum 0x0241 =E2=86=92 high 0x02)
    db 0x81, 0x2D        ; D3  (block 3)
    db 0xE5, 0x2D        ; F#3
    db 0x41, 0x2E        ; A3
    db 0x81, 0x31        ; D4  (block 4)
    db 0xE5, 0x31        ; F#4
    db 0x41, 0x32        ; A4

instrument:
    db 0x20, 0x21       ; mult=3D1, EG=3Don
    db 0x40, 0x10       ; KSL=3D0, TL=3D16
    db 0x60, 0xF0       ; attack=3D15, decay=3D0
    db 0x80, 0x77       ; sustain=3D7, release=3D7
    db 0xE0, 0x00       ; sine wave
    dw 0                ; terminator

message:
    db 'OPL2 vs OPL3 voice demo', 13, 10
    db 'Press any key to shutdown', 13, 10, 0

operator_offsets:
    db 0,1,2,3,4,5, 8,9,10,11,12,13, 16,17,18,19,20,21


times 510-($-$$) db 0
dw 0xAA55
```

To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Bryce Boe <bbzbryce@gmail.com>

--- b4-submit-tracking ---
# This section is used internally by b4 prep for tracking purposes.
{
  "series": {
    "revision": 1,
    "change-id": "20260505-sd16-opl3-74669607a11c",
    "prefixes": [],
    "presubject": ""
  }
}
--=20
2.49.1


